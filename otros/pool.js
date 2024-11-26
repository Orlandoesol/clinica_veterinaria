const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const { Pool } = require('pg');

const app = express();
const port = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Configuración de la conexión a PostgreSQL
const pool = new Pool({
    user: 'postgres',
    host: 'localhost',
    database: 'db_clinica_veterinaria',
    password: 'Admin12345*',
    port: 5432,
});

// Crear cliente
app.post('/clientes', async (req, res) => {
    const { id_cliente,nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email } = req.body;
    const result = await pool.query(
        'INSERT INTO clientes (id_cliente,nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING *',
        [id_cliente,nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email]
    );
    res.json(result.rows[0]);
});

// Leer clientes
app.get('/clientes', async (req, res) => {
    const result = await pool.query('SELECT * FROM clientes');
    res.json(result.rows);
});

// Actualizar cliente
app.put('/clientes/:id_cliente', async (req, res) => {
    const { id_cliente } = req.params;
    const { nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email } = req.body;
    const result = await pool.query(
        'UPDATE clientes SET nombre = $1, primer_apellido = $2, segundo_apellido = $3, telefono_1 = $4, telefono_2 = $5, email = $6 WHERE id_cliente = $7 RETURNING *',
        [nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email, id_cliente]
    );
    res.json(result.rows[0]);
});

// Eliminar cliente
app.delete('/clientes/:id_cliente', async (req, res) => {
    const { id_cliente } = req.params;
    await pool.query('DELETE FROM clientes WHERE id = $1', [id_cliente]);
    res.sendStatus(204);
});

// Iniciar el servidor
app.listen(port, () => {
    console.log(`Servidor escuchando en http://localhost:${port}`);
});