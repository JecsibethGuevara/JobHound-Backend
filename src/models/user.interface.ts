export interface User {
    id_user: number;
    id_profession: number;
    id_gender: number;
    id_role: number;
    id_city: number;
    first_name: string;
    last_name: string;
    created_at: Date;
    updated_at: Date;
    email: string;
    password_hash: string;
    date_of_birth: string;
    phone_number?: string | null;
}

export interface Role {
    id_role: number;
    role: string;
    description: string;
}

export interface Permission {
    id_permission: number;
    permission: string;
    description: string;
}

export interface Gender {
    id_gender: number;
    gender: string;
}

export interface Profession {
    id_profession: number;
    profession: string;
}

export interface Session {
    id_session: number;
    id_user: number;
    token: string;
    created_at: Date;
    updated_at: Date;
    expires_at: Date;
}
