import { ClientModel } from "../models/cliente.model.js";

// http://localhost:3000/api/v1/clientes/register
const register = async (req, res) => {
    try {
        console.log(req.body);//
        const {id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email} = req.body;
    if(!id_cliente || !nombre || !primer_apellido || !segundo_apellido || !telefono_1 || !telefono_2 || !email){
        return res.status(400).json({ok: false, 
                                    message: "Faltan campos!"});
    }
    const cliente = await ClientModel.findOneByEmail(email);
    if(cliente){
        return res.status(409).json({ok:true, 
                                    message: "El cliente ya existe!"});
    }

    //nueva fauncionalidad o faltante
    const newCliente = await ClientModel.create({id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email});

    return res.status(201).json({
        ok: true,
        message: newCliente //cambiar mensaje por cliente creado
    });
    
    }
    catch (error) {
        console.error(error);
        return res.status(500).json({
            ok: false,
            message: "Error al crear el cliente!"
        });
    }
}

export const ClientController = {
    register
}