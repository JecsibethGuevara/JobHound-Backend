"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const client_1 = require("../generated/prisma/client");
const faker_1 = require("@faker-js/faker");
const prisma = new client_1.PrismaClient();
async function main() {
    const countries = [];
    for (let i = 0; i < 20; i++) {
        countries.push(await prisma.country.create({
            data: {
                country: faker_1.faker.location.country(),
                zip_code: faker_1.faker.location.zipCode(),
            },
        }));
    }
    const roles = [];
    for (let i = 0; i < 20; i++) {
        roles.push(await prisma.role.create({
            data: {
                role: faker_1.faker.person.jobTitle(),
                description: faker_1.faker.lorem.sentence(),
            },
        }));
    }
    for (let i = 0; i < 20; i++) {
        await prisma.permission.create({
            data: {
                permission: faker_1.faker.lorem.word(),
                description: faker_1.faker.lorem.sentence(),
            },
        });
    }
    const professions = [];
    for (let i = 0; i < 20; i++) {
        professions.push(await prisma.profession.create({
            data: {
                profession: faker_1.faker.person.jobTitle(),
            },
        }));
    }
    const genders = [];
    for (let i = 0; i < 20; i++) {
        genders.push(await prisma.gender.create({
            data: {
                gender: faker_1.faker.person.sex(),
            },
        }));
    }
    const companies = [];
    for (let i = 0; i < 20; i++) {
        companies.push(await prisma.company.create({
            data: {
                company: faker_1.faker.company.name(),
                link: faker_1.faker.internet.url(),
            },
        }));
    }
    const boards = [];
    for (let i = 0; i < 20; i++) {
        boards.push(await prisma.board.create({
            data: {
                board: faker_1.faker.word.noun(),
                link: faker_1.faker.internet.url(),
            },
        }));
    }
    const positions = [];
    for (let i = 0; i < 20; i++) {
        positions.push(await prisma.position.create({
            data: {
                position: faker_1.faker.person.jobTitle(),
            },
        }));
    }
    const states = [];
    for (let i = 0; i < 20; i++) {
        const randomCountry = countries[Math.floor(Math.random() * countries.length)];
        states.push(await prisma.state.create({
            data: {
                state: faker_1.faker.location.state(),
                id_country: randomCountry.id_country,
            },
        }));
    }
    for (let i = 0; i < 20; i++) {
        const randomBoard = boards[Math.floor(Math.random() * boards.length)];
        await prisma.script.create({
            data: {
                script: faker_1.faker.lorem.paragraph(),
                id_board: randomBoard.id_board,
            },
        });
    }
    const cities = [];
    for (let i = 0; i < 20; i++) {
        const randomState = states[Math.floor(Math.random() * states.length)];
        cities.push(await prisma.city.create({
            data: {
                city: faker_1.faker.location.city(),
                id_state: randomState.id_state,
            },
        }));
    }
    const offers = [];
    for (let i = 0; i < 20; i++) {
        const randomBoard = boards[Math.floor(Math.random() * boards.length)];
        const randomCompany = companies[Math.floor(Math.random() * companies.length)];
        offers.push(await prisma.offer.create({
            data: {
                offer: faker_1.faker.person.jobTitle(),
                description: faker_1.faker.lorem.paragraph(),
                link: faker_1.faker.internet.url(),
                salary: faker_1.faker.finance.amount(),
                id_board: randomBoard.id_board,
                id_company: randomCompany.id_company,
            },
        }));
    }
    const users = [];
    for (let i = 0; i < 20; i++) {
        const randomProfession = professions[Math.floor(Math.random() * professions.length)];
        const randomGender = genders[Math.floor(Math.random() * genders.length)];
        const randomRole = roles[Math.floor(Math.random() * roles.length)];
        const randomCity = cities[Math.floor(Math.random() * cities.length)];
        users.push(await prisma.user.create({
            data: {
                first_name: faker_1.faker.person.firstName(),
                last_name: faker_1.faker.person.lastName(),
                email: faker_1.faker.internet.email(),
                password_hash: faker_1.faker.internet.password(),
                date_of_birth: faker_1.faker.date.birthdate().toISOString(),
                phone_number: faker_1.faker.phone.number(),
                id_profession: randomProfession.id_profession,
                id_gender: randomGender.id_gender,
                id_role: randomRole.id_role,
                id_city: randomCity.id_city,
            },
        }));
    }
    for (let i = 0; i < 20; i++) {
        const randomUser = users[Math.floor(Math.random() * users.length)];
        await prisma.session.create({
            data: {
                token: faker_1.faker.string.uuid(),
                expires_at: faker_1.faker.date.future(),
                id_user: randomUser.id_user,
            },
        });
    }
    for (let i = 0; i < 20; i++) {
        const randomUser = users[Math.floor(Math.random() * users.length)];
        await prisma.task.create({
            data: {
                task: faker_1.faker.lorem.sentence(),
                id_user: randomUser.id_user,
            },
        });
    }
    for (let i = 0; i < 20; i++) {
        const randomUser = users[Math.floor(Math.random() * users.length)];
        await prisma.goal.create({
            data: {
                goal: faker_1.faker.lorem.sentence(),
                id_user: randomUser.id_user,
            },
        });
    }
    for (let i = 0; i < 20; i++) {
        const randomUser = users[Math.floor(Math.random() * users.length)];
        const randomCompany = companies[Math.floor(Math.random() * companies.length)];
        const randomPosition = positions[Math.floor(Math.random() * positions.length)];
        await prisma.experience.create({
            data: {
                experience: faker_1.faker.lorem.paragraph(),
                start_date: faker_1.faker.date.past(),
                end_date: faker_1.faker.date.recent(),
                current: faker_1.faker.datatype.boolean(),
                id_user: randomUser.id_user,
                id_company: randomCompany.id_company,
                id_position: randomPosition.id_position,
            },
        });
    }
    for (let i = 0; i < 20; i++) {
        const randomUser = users[Math.floor(Math.random() * users.length)];
        const randomOffer = offers[Math.floor(Math.random() * offers.length)];
        await prisma.skill.create({
            data: {
                skill: faker_1.faker.person.jobArea(),
                id_user: randomUser.id_user,
                id_offer: randomOffer.id_offer,
            },
        });
    }
    const postulations = [];
    for (let i = 0; i < 20; i++) {
        const randomUser = users[Math.floor(Math.random() * users.length)] || null;
        const randomOffer = offers[Math.floor(Math.random() * offers.length)] || null;
        const user = randomUser ? randomUser.id_user : null;
        const offer = randomOffer ? randomOffer.id_offer : null;
        postulations.push(await prisma.postulation.create({
            data: {
                date: faker_1.faker.date.recent(),
                status: faker_1.faker.helpers.enumValue(client_1.Status),
                id_user: user,
                id_offer: offer,
            },
        }));
    }
    for (let i = 0; i < 20; i++) {
        const randomUser = users[Math.floor(Math.random() * users.length)];
        const randomPostulation = postulations[Math.floor(Math.random() * postulations.length)];
        await prisma.event.create({
            data: {
                event: faker_1.faker.helpers.enumValue(client_1.TypeEvent),
                start_date: faker_1.faker.date.soon(),
                end_date: faker_1.faker.date.future(),
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
//# sourceMappingURL=seed.js.map