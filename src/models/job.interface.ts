export interface Company {
    id_company: number;
    company?: string | null;
    link?: string | null;
}

export interface Board {
    id_board: number;
    board?: string | null;
    link?: string | null;
}

export interface Script {
    id_script: number;
    id_board: number;
    script: string;
}

export interface Offer {
    id_offer: number;
    id_board?: number | null;
    id_company?: number | null;
    offer?: string | null;
    description?: string | null;
    link?: string | null;
    salary?: string | null;
}

export interface Position {
    id_position: number;
    position?: string | null;
}

export interface Experience {
    id_experience: number;
    id_company?: number | null;
    id_position?: number | null;
    id_user?: number | null;
    start_date?: Date | null;
    end_date?: Date | null;
    current?: boolean | null;
    experience?: string | null;
}

export interface Skill {
    id_skill: number;
    id_user?: number | null;
    id_offer?: number | null;
    skill?: string | null;
}
