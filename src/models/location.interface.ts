export interface Country {
    id_country: number;
    country: string;
    zip_code: string;
}

export interface State {
    id_state: number;
    id_country: number;
    state: string;
}

export interface City {
    id_city: number;
    id_state: number;
    city: string;
}
