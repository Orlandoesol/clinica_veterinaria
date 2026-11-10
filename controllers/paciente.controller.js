import { PacienteModel } from '../models/paciente.model.js';

const registerPaciente = async (req, res) => {
    try {
        const { nombre_mascota, sexo, edad, peso, id_cliente } = req.body;

        if (!nombre_mascota || !sexo || !edad || !peso || !id_cliente) {
            return res.status(400).json({
                ok: false,
                message: 'Faltan campos obligatorios'
            });
        }

        const paciente = await PacienteModel.createPaciente({
            nombre_mascota,
            sexo,
            edad,
            peso,
            id_cliente
        });

        return res.status(201).json({
            ok: true,
            message: 'Paciente registrado correctamente',
            data: paciente
        });
    } catch (error) {
        console.error(error);
        return res.status(500).json({
            ok: false,
            message: error.message || 'Error al registrar el paciente'
        });
    }
};

const listPacientes = async (req, res) => {
    try {
        const pacientes = await PacienteModel.readPacientes();
        return res.json(pacientes);
    } catch (error) {
        console.error(error);
        return res.status(500).json({
            ok: false,
            message: 'Error al obtener los pacientes'
        });
    }
};

const searchPaciente = async (req, res) => {
    const { query } = req.query;

    if (!query || query.trim() === '') {
        return res.status(400).json({
            ok: false,
            message: 'Debe ingresar un criterio de búsqueda'
        });
    }

    try {
        const pacientes = await PacienteModel.findPacientesByQuery(query.trim());
        return res.json(pacientes);
    } catch (error) {
        console.error(error);
        return res.status(500).json({
            ok: false,
            message: 'Error al buscar pacientes'
        });
    }
};

const updatePaciente = async (req, res) => {
    const { id_paciente } = req.params;
    const updateFields = req.body;

    try {
        const pacienteActualizado = await PacienteModel.updatePaciente(id_paciente, updateFields);
        return res.status(200).json({
            ok: true,
            message: 'Paciente actualizado correctamente',
            data: pacienteActualizado
        });
    } catch (error) {
        console.error(error);
        return res.status(500).json({
            ok: false,
            message: error.message || 'Error al actualizar el paciente'
        });
    }
};

const deletePaciente = async (req, res) => {
    const { id_paciente } = req.params;

    try {
        const result = await PacienteModel.deletePaciente(id_paciente);
        return res.status(200).json({
            ok: true,
            message: 'Paciente eliminado correctamente',
            data: result
        });
    } catch (error) {
        console.error(error);
        return res.status(500).json({
            ok: false,
            message: error.message || 'Error al eliminar el paciente'
        });
    }
};

export const PacienteController = {
    registerPaciente,
    listPacientes,
    searchPaciente,
    updatePaciente,
    deletePaciente
};
