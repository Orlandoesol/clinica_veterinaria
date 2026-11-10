import { db } from '../database/conexion_db.js';

const ensureUsersTable = async () => {
    await db.query(`
        CREATE TABLE IF NOT EXISTS public.users (
            id SERIAL PRIMARY KEY,
            email VARCHAR(255) UNIQUE NOT NULL,
            password TEXT NOT NULL,
            role VARCHAR(50) NOT NULL DEFAULT 'user',
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        );
    `);
};

// CREATE
const createUser = async ({ email, password, role }) => {
    await ensureUsersTable();

    const query = {
        text: `
            INSERT INTO public.users (email, password, role)
            VALUES ($1, $2, $3)
            RETURNING id, email, password, role
        `,
        values: [email, password, role]
    };

    const { rows } = await db.query(query);
    return rows[0];
};

// READ
const showUser = async () => {
    await ensureUsersTable();

    const { rows } = await db.query(`
        SELECT id, email, role, created_at
        FROM public.users
        ORDER BY created_at DESC
    `);
    return rows;
};

const findOneByEmail = async (email) => {
    await ensureUsersTable();

    const { rows } = await db.query(`
        SELECT *
        FROM public.users
        WHERE email = $1
    `, [email]);
    return rows[0];
};

export const UserModel = {
    createUser,
    showUser,
    findOneByEmail
};