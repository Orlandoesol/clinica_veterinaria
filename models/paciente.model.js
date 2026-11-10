import { db } from '../database/conexion_db.js';

const ensureClientesTable = async () => {
    await db.query(`
        CREATE TABLE IF NOT EXISTS public.clientes (
            id_cliente BIGINT PRIMARY KEY,
            nombre VARCHAR(100) NOT NULL,
            primer_apellido VARCHAR(100) NOT NULL,
            segundo_apellido VARCHAR(100) NOT NULL,
            telefono_1 VARCHAR(15) NOT NULL,
            telefono_2 VARCHAR(15),
            email VARCHAR(100) UNIQUE NOT NULL
        );
    `);
};

const ensurePacientesTable = async () => {
    await ensureClientesTable();

    await db.query(`
        CREATE TABLE IF NOT EXISTS public.pacientes (
            id_paciente SERIAL PRIMARY KEY,
            nombre_mascota VARCHAR(100) NOT NULL,
            sexo VARCHAR(30) NOT NULL,
            edad INTEGER NOT NULL,
            peso NUMERIC(5,2) NOT NULL,
            id_cliente BIGINT NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            CONSTRAINT fk_cliente FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente) ON DELETE CASCADE
        );
    `);
};

const createPaciente = async ({ nombre_mascota, sexo, edad, peso, id_cliente }) => {
    await ensurePacientesTable();

    const cliente = await db.query(`
        SELECT id_cliente FROM public.clientes WHERE id_cliente = $1
    `, [id_cliente]);

    if (cliente.rows.length === 0) {
        throw new Error('El cliente asociado no existe');
    }

    const query = {
        text: `
            INSERT INTO public.pacientes (nombre_mascota, sexo, edad, peso, id_cliente)
            VALUES ($1, $2, $3, $4, $5)
            RETURNING *
        `,
        values: [nombre_mascota, sexo, edad, peso, id_cliente]
    };

    const { rows } = await db.query(query);
    return rows[0];
};

const readPacientes = async () => {
    await ensurePacientesTable();

    const { rows } = await db.query(`
        SELECT p.id_paciente, p.nombre_mascota, p.sexo, p.edad, p.peso, p.id_cliente,
               c.nombre, c.primer_apellido, c.telefono_1, c.telefono_2
        FROM public.pacientes p
        LEFT JOIN public.clientes c ON c.id_cliente = p.id_cliente
        ORDER BY p.id_paciente ASC
    `);

    return rows;
};

const findPacienteById = async (id_paciente) => {
    await ensurePacientesTable();

    const { rows } = await db.query(`
        SELECT *
        FROM public.pacientes
        WHERE id_paciente = $1
    `, [id_paciente]);

    return rows[0];
};

const findPacientesByQuery = async (query) => {
    await ensurePacientesTable();

    const search = `%${query}%`;
    const { rows } = await db.query(`
        SELECT p.id_paciente, p.nombre_mascota, p.sexo, p.edad, p.peso, p.id_cliente,
               c.nombre, c.primer_apellido, c.telefono_1, c.telefono_2
        FROM public.pacientes p
        LEFT JOIN public.clientes c ON c.id_cliente = p.id_cliente
        WHERE p.nombre_mascota ILIKE $1 OR c.nombre ILIKE $1 OR c.email ILIKE $1
        ORDER BY p.id_paciente ASC
    `, [search]);

    return rows;
};

const updatePaciente = async (id_paciente, updateFields) => {
    await ensurePacientesTable();

    const keys = Object.keys(updateFields);
    if (!keys.length) {
        throw new Error('No hay campos para actualizar');
    }

    const setClause = keys.map((key, index) => `"${key}" = $${index + 2}`).join(', ');
    const values = [id_paciente, ...Object.values(updateFields)];

    const query = {
        text: `
            UPDATE public.pacientes
            SET ${setClause}
            WHERE id_paciente = $1
            RETURNING *
        `,
        values
    };

    const { rows } = await db.query(query);
    if (rows.length === 0) {
        throw new Error('Paciente no encontrado');
    }

    return rows[0];
};

const deletePaciente = async (id_paciente) => {
    await ensurePacientesTable();

    const result = await db.query(`
        DELETE FROM public.pacientes
        WHERE id_paciente = $1
    `, [id_paciente]);

    if (result.rowCount === 0) {
        throw new Error('Paciente no encontrado');
    }

    return { success: true, message: 'Paciente eliminado' };
};

export const PacienteModel = {
    createPaciente,
    readPacientes,
    findPacienteById,
    findPacientesByQuery,
    updatePaciente,
    deletePaciente
};
