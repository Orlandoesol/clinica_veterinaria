import { ClientModel } from "../models/cliente.model.js";

// http://localhost:3000/api/v1/clientes/register
const registerCliente = async (req, res) => {
    try {
        const { id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email } = req.body;

        if (!id_cliente || !nombre || !primer_apellido || !segundo_apellido || !telefono_1 || !telefono_2 || !email) {
            return res.status(400).json({
                ok: false,
                message: "Faltan campos!"
            });
        }

        const cliente = await ClientModel.findOneByEmail(email);
        if (cliente) {
            return res.status(409).json({
                ok: false,
                message: "El cliente ya existe!"
            });
        }

        const newCliente = await ClientModel.createCliente({
            id_cliente,
            nombre,
            primer_apellido,
            segundo_apellido,
            telefono_1,
            telefono_2,
            email
        });

        return res.status(201).json({
            ok: true,
            message: "Cliente creado correctamente",
            data: newCliente
        });
    } catch (error) {
        console.error(error);
        return res.status(500).json({
            ok: false,
            message: "Error al crear el cliente!"
        });
    }
};

// http://localhost:3000/api/v1/clientes/list
const listCliente = async (req, res) => {
    try {
        const clientes = await ClientModel.readCliente();
        return res.json(clientes);
    } catch (error) {
        console.error(error);
        return res.status(500).json({ message: 'Error al obtener los clientes' });
    }
};

const searchCliente = async (req, res) => {
    const { query } = req.query;

    if (!query || query.trim() === '') {
        return res.status(400).json({
            ok: false,
            message: 'Debe ingresar un valor para buscar'
        });
    }

    try {
        const clients = await ClientModel.findIdOrEmail(query.trim());
        return res.json(clients);
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            ok: false,
            message: 'Error server'
        });
    }
};

// http://localhost:3000/api/v1/clientes/deleteClients
const deleteCliente = async (req, res) => {
    const { id_cliente } = req.params;
    const userRole = req.role;

    if (userRole !== 'Superadmin' && userRole !== 'usu2') {
        return res.status(403).json({
            ok: false,
            message: 'No tienes permisos para eliminar clientes'
        });
    }

    try {
        const result = await ClientModel.deleteCliente(id_cliente);
        return res.status(200).json({
            ok: true,
            message: 'Cliente eliminado correctamente',
            data: result
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            ok: false,
            message: error.message || 'Error al eliminar el cliente'
        });
    }
};

const updateClient = async (req, res) => {
    const { id_cliente } = req.params;
    const updateFields = req.body;

    try {
        const updatedClient = await ClientModel.updateCliente(id_cliente, updateFields);
        return res.status(200).json({
            ok: true,
            message: 'Cliente actualizado correctamente',
            data: updatedClient
        });
    } catch (error) {
        console.log(error);
        return res.status(500).json({
            ok: false,
            message: error.message || 'Error al actualizar el cliente'
        });
    }
};

export const ClientController = {
    registerCliente,
    listCliente,
    searchCliente,
    deleteCliente,
    updateClient
};