import { ClientModel } from "../models/cliente.model.js";

// api/v1/cliente/register
const register = async (req, res) => {
    try {
        const {id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email} = req.body;
    if(!id_cliente || !nombre || !primer_apellido || !segundo_apellido || !telefono_1 || !telefono_2 || !email){
        return res.status(400).json({ok:false, message: "Faltan campos!"});
    }

    const cliente = await ClientModel.findOneByEmail(email);
    if(cliente){
        return res.status(409).json({ok:false, message: "El cliente ya existe!"});
    }

    return res.status(201).json({
        ok: true,
        message: "Cliente creado con éxito!",
    })
    
    }
    catch (error) {
        console.error(error);
        res.status(500).json({
            ok: false,
            message: "Error al crear el clientee!"
        });
    }
}

// api/v1/cliente/show




export const ClientController = {
    register
}