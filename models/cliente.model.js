import { db } from '../database/conexion_db.js';

const ensureClientesTable = async () => {
    await db.query(`
        CREATE TABLE IF NOT EXISTS public.clientes (
            id_cliente INTEGER PRIMARY KEY,
            nombre VARCHAR(100) NOT NULL,
            primer_apellido VARCHAR(100) NOT NULL,
            segundo_apellido VARCHAR(100) NOT NULL,
            telefono_1 VARCHAR(30) NOT NULL,
            telefono_2 VARCHAR(30),
            email VARCHAR(255) UNIQUE NOT NULL
        );
    `);
};

//Metodo Create
const createCliente = async ({ id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email }) => {
    await ensureClientesTable();

    const query = {
        text: `
            INSERT INTO public.clientes (id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email)
            VALUES ($1, $2, $3, $4, $5, $6, $7)
            RETURNING *
        `,
        values: [id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email]
    };

    const { rows } = await db.query(query);
    return rows[0];
}

//Metodo Read
const readCliente = async () => {
    await ensureClientesTable();

    const { rows } = await db.query(`
        SELECT *
        FROM public.clientes
        ORDER BY id_cliente ASC
    `);
    return rows;
}

const updateCliente = async (id_cliente, updateFields) => {
    await ensureClientesTable();

    const keys = Object.keys(updateFields);
    if (!keys.length) {
        throw new Error('No hay campos para actualizar');
    }

    const setClause = keys.map((key, index) => `"${key}" = $${index + 2}`).join(', ');
    const values = [id_cliente, ...Object.values(updateFields)];

    const updateQuery = {
        text: `
            UPDATE public.clientes
            SET ${setClause}
            WHERE id_cliente = $1
            RETURNING *
        `,
        values
    };

    const { rows } = await db.query(updateQuery);
    if (rows.length === 0) {
        throw new Error('Cliente no encontrado');
    }

    return rows[0];
};

//Buscar o validar por email
const findOneByEmail = async (email) => {
    await ensureClientesTable();

    const { rows } = await db.query(`
        SELECT *
        FROM public.clientes
        WHERE email = $1
    `, [email]);
    return rows[0];
}
//Buscar por ID
const findById_cliente = async (id_cliente) => {
    await ensureClientesTable();

    const { rows } = await db.query(`
        SELECT *
        FROM public.clientes
        WHERE id_cliente = $1
    `, [id_cliente]);
    return rows[0];
}
//Buscar por ID o email
const findIdOrEmail = async (query) => {
    await ensureClientesTable();

    let queryText;
    let values;

    if (!isNaN(query)) {
        queryText = `
            SELECT *
            FROM public.clientes
            WHERE id_cliente = $1
        `;
        values = [query];
    } else {
        queryText = `
            SELECT *
            FROM public.clientes
            WHERE email ILIKE $1
        `;
        values = [`%${query}%`];
    }

    const { rows } = await db.query({
        text: queryText,
        values
    });

    return rows;
}

//Metodo Delete
const deleteCliente = async (id_cliente) => {
    await ensureClientesTable();

    const deleteQuery = {
        text: `
            DELETE FROM public.clientes
            WHERE id_cliente = $1
        `,
        values: [id_cliente]
    };

    const result = await db.query(deleteQuery);
    if (result.rowCount === 0) {
        throw new Error('Cliente no encontrado');
    }

    return { success: true, message: 'Cliente eliminado' };
};

export const ClientModel = {
    createCliente,
    readCliente,
    updateCliente,
    deleteCliente,
    findOneByEmail,
    findById_cliente,
    findIdOrEmail
};