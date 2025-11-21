import {
  Injectable,
  NestInterceptor,
  ExecutionContext,
  CallHandler,
} from '@nestjs/common';
import { Response } from 'express';
import { Observable } from 'rxjs';
import { map } from 'rxjs/operators';

@Injectable()
export class RequestInterceptor<T>
  implements
    NestInterceptor<
      T,
      { data: T; status: number; message: string; timestamp: string }
    >
{
  intercept(
    context: ExecutionContext,
    next: CallHandler,
  ): Observable<{
    data: T;
    status: number;
    message: string;
    timestamp: string;
  }> {
    return next.handle().pipe(
      map((data: T) => ({
        data: data,
        status: context.switchToHttp().getResponse<Response>().statusCode,
        message: 'Successful Request',
        timestamp: new Date().toISOString(),
      })),
    );
  }
}
