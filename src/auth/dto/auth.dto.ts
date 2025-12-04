import { IsEmail, IsNotEmpty, MinLength } from "class-validator";

export class AuthCreateUserDto {
    @IsEmail()
    readonly email: string;
    @IsNotEmpty()
    @MinLength(6, { message: 'Password must be at least 6 characters long' })
    readonly password: string;
}