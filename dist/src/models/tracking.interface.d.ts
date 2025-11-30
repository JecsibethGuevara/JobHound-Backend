export declare enum Status {
    APPLIED = "APPLIED",
    INTERVIEW = "INTERVIEW",
    REJECTED = "REJECTED",
    OFFER = "OFFER",
    ACCEPTED = "ACCEPTED"
}
export declare enum TypeEvent {
    INTERVIEW = "INTERVIEW",
    MEETING = "MEETING",
    REMINDER = "REMINDER",
    FOLLOW_UP = "FOLLOW_UP"
}
export interface Task {
    id_task: number;
    id_user: number;
    task?: string | null;
}
export interface Goal {
    id_goal: number;
    id_user: number;
    goal?: string | null;
}
export interface Postulation {
    id_postulation: number;
    id_user?: number | null;
    id_offer?: number | null;
    date?: Date | null;
    status: Status;
}
export interface Event {
    id_event: number;
    id_user: number;
    id_postulation?: number | null;
    event: TypeEvent;
    start_date: Date;
    end_date: Date;
}
