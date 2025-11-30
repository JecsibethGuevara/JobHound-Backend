import { Board, City, Company, Country, Gender, Offer, Position, Postulation, Profession, Role, State, User } from 'src/models';
import { PrismaClient, Status, TypeEvent } from '../generated/prisma/client';
import { faker } from '@faker-js/faker';

const prisma = new PrismaClient();

async function main() {

    // 1. Independent Models

    // Countries
    const countries: Country[] = [];
    for (let i = 0; i < 20; i++) {
        countries.push(await prisma.country.create({
            data: {
                country: faker.location.country(),
                zip_code: faker.location.zipCode(),
            },
        }));
    }

    // Roles
    const roles: Role[] = [];
    for (let i = 0; i < 20; i++) {
        roles.push(await prisma.role.create({
            data: {
                role: faker.person.jobTitle(),
                description: faker.lorem.sentence(),
            },
        }));
    }

    // Permissions
    for (let i = 0; i < 20; i++) {
        await prisma.permission.create({
            data: {
                permission: faker.lorem.word(),
                description: faker.lorem.sentence(),
            },
        });
    }

    // Professions
    const professions: Profession[] = [];
    for (let i = 0; i < 20; i++) {
        professions.push(await prisma.profession.create({
            data: {
                profession: faker.person.jobTitle(),
            },
        }));
    }

    // Genders
    const genders: Gender[] = [];
    for (let i = 0; i < 20; i++) {
        genders.push(await prisma.gender.create({
            data: {
                gender: faker.person.sex(),
            },
        }));
    }

    // Companies
    const companies: Company[] = [];
    for (let i = 0; i < 20; i++) {
        companies.push(await prisma.company.create({
            data: {
                company: faker.company.name(),
                link: faker.internet.url(),
            },
        }));
    }

    // Boards
    const boards: Board[] = [];
    for (let i = 0; i < 20; i++) {
        boards.push(await prisma.board.create({
            data: {
                board: faker.word.noun(),
                link: faker.internet.url(),
            },
        }));
    }

    // Positions
    const positions: Position[] = [];
    for (let i = 0; i < 20; i++) {
        positions.push(await prisma.position.create({
            data: {
                position: faker.person.jobTitle(),
            },
        }));
    }

    // 2. Dependent Models - Level 1

    // States (depend on Country)
    const states: State[] = [];
    for (let i = 0; i < 20; i++) {
        const randomCountry = countries[Math.floor(Math.random() * countries.length)];
        states.push(await prisma.state.create({
            data: {
                state: faker.location.state(),
                id_country: randomCountry.id_country,
            },
        }));
    }

    // Scripts (depend on Board)
    for (let i = 0; i < 20; i++) {
        const randomBoard = boards[Math.floor(Math.random() * boards.length)];
        await prisma.script.create({
            data: {
                script: faker.lorem.paragraph(),
                id_board: randomBoard.id_board,
            },
        });
    }

    // 3. Dependent Models - Level 2

    // Cities (depend on State)
    const cities: City[] = [];
    for (let i = 0; i < 20; i++) {
        const randomState = states[Math.floor(Math.random() * states.length)];
        cities.push(await prisma.city.create({
            data: {
                city: faker.location.city(),
                id_state: randomState.id_state,
            },
        }));
    }

    // Offers (depend on Board, Company)
    const offers: Offer[] = [];
    for (let i = 0; i < 20; i++) {
        const randomBoard = boards[Math.floor(Math.random() * boards.length)];
        const randomCompany = companies[Math.floor(Math.random() * companies.length)];
        offers.push(await prisma.offer.create({
            data: {
                offer: faker.person.jobTitle(),
                description: faker.lorem.paragraph(),
                link: faker.internet.url(),
                salary: faker.finance.amount(),
                id_board: randomBoard.id_board,
                id_company: randomCompany.id_company,
            },
        }));
    }

    // 4. Dependent Models - Level 3 (Users)

    const users: User[] = [];
    for (let i = 0; i < 20; i++) {
        const randomProfession = professions[Math.floor(Math.random() * professions.length)];
        const randomGender = genders[Math.floor(Math.random() * genders.length)];
        const randomRole = roles[Math.floor(Math.random() * roles.length)];
        const randomCity = cities[Math.floor(Math.random() * cities.length)];

        users.push(await prisma.user.create({
            data: {
                first_name: faker.person.firstName(),
                last_name: faker.person.lastName(),
                email: faker.internet.email(),
                password_hash: faker.internet.password(), // In real app, hash this!
                date_of_birth: faker.date.birthdate().toISOString(),
                phone_number: faker.phone.number(),
                id_profession: randomProfession.id_profession,
                id_gender: randomGender.id_gender,
                id_role: randomRole.id_role,
                id_city: randomCity.id_city,
            },
        }));
    }

    // 5. Dependent Models - Level 4 (User dependent)

    // Sessions
    for (let i = 0; i < 20; i++) {
        const randomUser = users[Math.floor(Math.random() * users.length)];
        await prisma.session.create({
            data: {
                token: faker.string.uuid(),
                expires_at: faker.date.future(),
                id_user: randomUser.id_user,
            },
        });
    }

    // Tasks
    for (let i = 0; i < 20; i++) {
        const randomUser = users[Math.floor(Math.random() * users.length)];
        await prisma.task.create({
            data: {
                task: faker.lorem.sentence(),
                id_user: randomUser.id_user,
            },
        });
    }

    // Goals
    for (let i = 0; i < 20; i++) {
        const randomUser = users[Math.floor(Math.random() * users.length)];
        await prisma.goal.create({
            data: {
                goal: faker.lorem.sentence(),
                id_user: randomUser.id_user,
            },
        });
    }

    // Experiences
    for (let i = 0; i < 20; i++) {
        const randomUser = users[Math.floor(Math.random() * users.length)];
        const randomCompany = companies[Math.floor(Math.random() * companies.length)];
        const randomPosition = positions[Math.floor(Math.random() * positions.length)];

        await prisma.experience.create({
            data: {
                experience: faker.lorem.paragraph(),
                start_date: faker.date.past(),
                end_date: faker.date.recent(),
                current: faker.datatype.boolean(),
                id_user: randomUser.id_user,
                id_company: randomCompany.id_company,
                id_position: randomPosition.id_position,
            },
        });
    }

    // Skills
    for (let i = 0; i < 20; i++) {
        const randomUser = users[Math.floor(Math.random() * users.length)];
        const randomOffer = offers[Math.floor(Math.random() * offers.length)];

        await prisma.skill.create({
            data: {
                skill: faker.person.jobArea(),
                id_user: randomUser.id_user,
                id_offer: randomOffer.id_offer,
            },
        });
    }

    // Postulations
    const postulations: Postulation[] = [];
    for (let i = 0; i < 20; i++) {
        const randomUser = users[Math.floor(Math.random() * users.length)] || null;
        const randomOffer = offers[Math.floor(Math.random() * offers.length)] || null;
        const user = randomUser ? randomUser.id_user : null;
        const offer = randomOffer ? randomOffer.id_offer : null;

        postulations.push(await prisma.postulation.create({
            data: {
                date: faker.date.recent(),
                status: faker.helpers.enumValue(Status),
                id_user: user,
                id_offer: offer,
            },
        }) as unknown as Postulation);
    }

    // 6. Dependent Models - Level 5 (Postulation dependent)

    // Events
    for (let i = 0; i < 20; i++) {
        const randomUser = users[Math.floor(Math.random() * users.length)];
        const randomPostulation = postulations[Math.floor(Math.random() * postulations.length)];

        await prisma.event.create({
            data: {
                event: faker.helpers.enumValue(TypeEvent),
                start_date: faker.date.soon(),
                end_date: faker.date.future(),
                id_user: randomUser.id_user,
                id_postulation: randomPostulation.id_postulation,
            },
        });
    }

}

main()
    .catch((e) => {
        console.error(e);
        process.exit(1);
    })
    .finally(async () => {
        await prisma.$disconnect();
    });
