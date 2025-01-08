import {db} from '../database/conexion_db.js';
//Metodo Create
const createCliente = async ({id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email}) => {
    const query = {
        text: `
        INSERT INTO clinica.clientes (id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email)
        VALUES ($1, $2, $3, $4, $5, $6, $7)
        RETURNING *
        `,
        values: [id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email]
    }

    const { rows } = await db.query(query);
    return rows[0];
}

//Metodo Read
const readCliente = async () => {
    const result = {
        text: `
        SELECT * FROM clinica.clientes`
    }
    const { rows } = await db.query(result);
    return rows
}

const updateCliente = async (id_cliente, updateFields) => {
    const setClause = Object.keys(updateFields).map((key, index) => `${key} = $${index + 2}`).join(', ');
    const values = [id_cliente, ...Object.values(updateFields)];

    const updateQuery = {
        text: `
        UPDATE clinica.clientes
        SET ${setClause}
        WHERE id_cliente = $1
        RETURNING *
        `,
        values: values
    };

    try {
        const { rows } = await db.query(updateQuery);
        if (rows.length === 0) {
            throw new Error('Cliente no encontrado');
        }
        return rows[0];
    } catch (error) {
        console.error('Error al actualizar el cliente:', error);
        throw new Error('Error al intentar actualizar el cliente');
    }
};

//Buscar o validar por email
const findOneByEmail = async (email) => {
    const query = {
        text: `
        SELECT * FROM clinica.clientes 
        WHERE email = $1
        `,
        values: [email]//faltaba
    }
    const {rows} = await db.query(query, [email]);
    return rows[0];
}
//Buscar por ID
const findById_cliente = async (id_cliente) => {
    const query = {
        text: `
        SELECT * FROM clinica.clientes
        WHERE id_cliente = $1
        `,
        values: [id_cliente]
    }
    const { rows } = await db.query(query)
    return rows[0]
}
//Buscar por ID o email
const findIdOrEmail = async (query) => {
    let queryText;
    let values;

    // Si el query es un número (id_cliente)
    if (!isNaN(query)) {
        queryText = `
        SELECT * FROM clinica.clientes 
        WHERE id_cliente = $1`;
        values = [query];
    }
    // Si el query es un email (cadena de texto)
    else {
        queryText = `
        SELECT * FROM clinica.clientes 
        WHERE email = $1`;
        values = [query];
    }
    const { rows } = await db.query({
        text: queryText,
        values: values
    });
    return rows;
}

//Metodo Delete
const deleteCliente = async (id_cliente) => {
    const deleteQuery = {
        text: `
        DELETE FROM clinica.clientes
        WHERE id_cliente = $1
        `,
        values: [id_cliente]
    }
    try {
        const result = await db.query(deleteQuery);
        if (result.rowCount === 0) {
            throw new Error('Cliente no encontrado');
    }
     // Si la eliminación fue exitosa, podemos devolver un mensaje o un valor
        return { success: true, message: 'Cliente eliminado' };

    }catch (error) {
        // Manejo de errores en caso de fallos en la consulta
        console.error('Error al eliminar el cliente:', error);
        throw new Error('Error al intentar eliminar el cliente');
        
    }
}


export const ClientModel = {
    createCliente,
    readCliente,
    updateCliente,
    deleteCliente,
    findOneByEmail,
    findById_cliente,
    findIdOrEmail
}