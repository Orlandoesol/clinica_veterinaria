const {Client} = require('pg')
const client = new Client ({
    user: 'postgres',
    host: 'localhost',
    database: 'db_clinica_veterinaria',
    password: 'Admin12345*',
    port: 5432
})

/* client.connect()
.then(() => console.log('Conexion Exitosa!!'))
.then(() => client.query('SELECT * FROM paciente'))
.then(result => console.table(result.rows))
.catch((err) => console.log(err))
.finally(() => client.end()) */


execute()
async function execute() {
    try {
    await client.connect()
    console.log('Conexión Exitosa!!')
    //const result = await client.query('SELECT * FROM veterinarios')
    //const result = await client.query('SELECT e.especie, COUNT(*) AS numero_pacientes FROM paciente p JOIN especie e ON p.id_Paciente = e.id_especie_paciente GROUP BY e.especie')
    //const result = await client.query("INSERT INTO clientes (id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email) VALUES (1095689566, 'Margarita', 'Marin', 'Ocampo', '32156897456', '311563365896', 'margarita@email.com')")
    const result = await client.query('SELECT * FROM clientes')
    console.table(result.rows)
    }
    catch (err){
        console.error(`Algo ha sucedido! ${err}`)
    }
    finally {
        await client.end()
        console.log("Cierre de conexion, Exitosa!!")
    }
}