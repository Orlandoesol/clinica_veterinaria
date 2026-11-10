document.addEventListener('DOMContentLoaded', () => {
    const formPaciente = document.getElementById('formPaciente');
    const searchInput = document.getElementById('searchPaciente');

    const token = localStorage.getItem('token');
    if (!token) {
        window.location.href = '/login';
        return;
    }

    const bindLogout = () => {
        const logoutBtn = document.getElementById('logoutBtn');
        if (logoutBtn) {
            logoutBtn.addEventListener('click', () => {
                localStorage.removeItem('token');
                window.location.href = '/login';
            });
        }
    };

    const renderRows = (pacientes) => {
        const tbody = document.getElementById('tb_pets');
        tbody.innerHTML = '';

        if (!Array.isArray(pacientes) || pacientes.length === 0) {
            tbody.innerHTML = `
                <tr>
                    <td colspan="8" class="text-center">No hay pacientes registrados</td>
                </tr>
            `;
            return;
        }

        pacientes.forEach((paciente) => {
            const row = document.createElement('tr');
            row.innerHTML = `
                <td>${paciente.id_paciente}</td>
                <td>${paciente.nombre_mascota}</td>
                <td>${paciente.sexo}</td>
                <td>${paciente.edad}</td>
                <td>${paciente.peso}</td>
                <td>${paciente.nombre || '-'}</td>
                <td>${paciente.telefono_1 || '-'}</td>
                <td>
                    <button class="btn btn-warning btn-sm" onclick="updatePaciente('${paciente.id_paciente}')">Actualizar</button>
                    <button class="btn btn-danger btn-sm" onclick="deletePaciente('${paciente.id_paciente}')">Eliminar</button>
                </td>
            `;
            tbody.appendChild(row);
        });
    };

    async function loadPacientes() {
        try {
            const { data } = await axios.get('/api/v1/pacientes/list', {
                headers: { Authorization: `Bearer ${token}` }
            });
            renderRows(data);
        } catch (error) {
            console.error(error);
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: error.response?.data?.message || 'No se pudieron cargar los pacientes'
            });
        }
    }

    formPaciente.addEventListener('submit', async (e) => {
        e.preventDefault();

        const payload = {
            nombre_mascota: e.target.pets.value.trim(),
            sexo: e.target.sexo.value.trim(),
            edad: Number(e.target.edad.value),
            peso: Number(e.target.peso.value),
            id_cliente: Number(e.target.id_cliente.value)
        };

        if (!payload.nombre_mascota || !payload.sexo || !payload.edad || !payload.peso || !payload.id_cliente) {
            Swal.fire({
                icon: 'warning',
                title: 'Campos incompletos',
                text: 'Completa todos los campos del paciente'
            });
            return;
        }

        try {
            await axios.post('/api/v1/pacientes/register', payload, {
                headers: { Authorization: `Bearer ${token}` }
            });

            formPaciente.reset();
            Swal.fire({
                icon: 'success',
                title: 'Paciente registrado',
                text: 'El paciente ha sido registrado exitosamente'
            });
            loadPacientes();
        } catch (error) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: error.response?.data?.message || 'Error al registrar el paciente'
            });
        }
    });

    window.loadPacientes = loadPacientes;

    window.deletePaciente = async function(id_paciente) {
        try {
            await axios.delete(`/api/v1/pacientes/${id_paciente}`, {
                headers: { Authorization: `Bearer ${token}` }
            });

            Swal.fire({
                icon: 'success',
                title: 'Paciente eliminado',
                text: 'El paciente fue eliminado correctamente'
            });
            loadPacientes();
        } catch (error) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: error.response?.data?.message || 'Error al eliminar el paciente'
            });
        }
    };

    window.updatePaciente = async function(id_paciente) {
        const nombre_mascota = prompt('Nuevo nombre de la mascota:');
        const sexo = prompt('Nuevo sexo:');
        const edad = prompt('Nueva edad:');
        const peso = prompt('Nuevo peso:');
        const id_cliente = prompt('Nuevo ID del cliente:');

        if (!nombre_mascota && !sexo && !edad && !peso && !id_cliente) {
            return;
        }

        const updateFields = {};
        if (nombre_mascota) updateFields.nombre_mascota = nombre_mascota.trim();
        if (sexo) updateFields.sexo = sexo.trim();
        if (edad) updateFields.edad = Number(edad);
        if (peso) updateFields.peso = Number(peso);
        if (id_cliente) updateFields.id_cliente = Number(id_cliente);

        try {
            await axios.patch(`/api/v1/pacientes/${id_paciente}`, updateFields, {
                headers: { Authorization: `Bearer ${token}` }
            });

            Swal.fire({
                icon: 'success',
                title: 'Paciente actualizado',
                text: 'Los datos se actualizaron correctamente'
            });
            loadPacientes();
        } catch (error) {
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: error.response?.data?.message || 'Error al actualizar el paciente'
            });
        }
    };

    if (searchInput) {
        searchInput.addEventListener('input', async (e) => {
            const value = e.target.value.trim();
            if (!value) {
                loadPacientes();
                return;
            }

            try {
                const { data } = await axios.get(`/api/v1/pacientes/search?query=${encodeURIComponent(value)}`, {
                    headers: { Authorization: `Bearer ${token}` }
                });
                renderRows(data);
            } catch (error) {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: error.response?.data?.message || 'Error en la búsqueda'
                });
            }
        });
    }

    bindLogout();
    loadPacientes();
});
