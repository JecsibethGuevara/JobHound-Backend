import {
  ArgumentsHost,
  Catch,
  ExceptionFilter,
  HttpException,
  HttpStatus,
} from '@nestjs/common';
import { Response } from 'express';
import { ExceptionResponse } from 'src/types/general.interfaces';

@Catch()
export class HttpExceptionFilterFilter implements ExceptionFilter {
  catch(exception: unknown, host: ArgumentsHost) {
    const ctx = host.switchToHttp();
    const response = ctx.getResponse<Response>();

    let status: number;
    let message: string = '';
    let data: unknown | null = null;

    if (exception instanceof HttpException) {
      status = exception.getStatus();
      const exceptionResponse = exception.getResponse();
      data = exceptionResponse;
      if (typeof exceptionResponse === 'string') {
        message = exceptionResponse;
      } else {
        const response = exceptionResponse as ExceptionResponse;
        message =
          response.message?.toString() ||
          response.error?.toString() ||
          exception.message;
      }
    } else {
      status = HttpStatus.INTERNAL_SERVER_ERROR;
      message = 'Internal server error';
    }
    response.status(status).json({
      data: data || null,
      status,
      message,
      timestamp: new Date().toISOString(),
    });
  }
}
