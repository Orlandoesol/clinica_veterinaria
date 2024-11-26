import 'dotenv/config';
import express from 'express';
import clienteRouter from './routes/cliente.route.js';

const app = express();


/* app.get('/', (req,res) => {
    res.send('Hello World!')
}); */

app.use(express.json());
app.use(express.urlencoded({ extended: true}));


app.use(express.static('public'));

//app.use('/', cliente.route );

app.use('api/v1/cliente', clienteRouter);

//RUTAS
const PORT = process.env.PORT || 3000;

//Levantar el servidor
app.listen(PORT, () => { console.log(`Servidor escuchando en el puerto ${PORT}`)});