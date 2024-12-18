import {db} from '../database/conexion_db.js';

const create = async ({id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email}) => {
    const query = {
        text: `
        INSERT INTO clinica.clientes (id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email)
        VALUES ($1, $2, $3, $4, $5, $6, $7)
        RETURNING *
        `,
        values: [id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email]
    }
//(1076017781, 'Juan', 'Pérez', 'Ortiz', '123456789', '987654321', 'juan@email.com')
    const { rows } = await db.query(query);//faltaba definir el rows
    return rows[0];
}

//Mostrar datos de los clientes
const show = async (req, res) => {
    const result = await db.query('SELECT * FROM clinica.clientes');
    res.json(result.rows);
}


//Buscar o validar si el email
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


export const ClientModel = {
    create,
    show,
    findOneByEmail
}