document.addEventListener('DOMContentLoaded', () => {
    const token = localStorage.getItem('token');
    if (!token) {
        window.location.href = '/login';
        return;
    }

    const resgisterClient = document.querySelector('#formCliente');
    const logoutBtn = document.getElementById('logoutBtn');

    if (logoutBtn) {
        logoutBtn.addEventListener('click', () => {
            localStorage.removeItem('token');
            window.location.href = '/login';
        });
    }

    resgisterClient.addEventListener('submit', async e => {
        e.preventDefault();
        const id_cliente = e.target.id_cliente.value;
        const nombre = e.target.nombre.value;
        const primer_apellido = e.target.primer_apellido.value;
        const segundo_apellido = e.target.segundo_apellido.value;
        const telefono_1 = e.target.telefono_1.value;
        const telefono_2 = e.target.telefono_2.value;
        const email = e.target.email.value;

        try {
            await axios.post('/api/v1/clientes/register', {
                id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email
            }, {
                headers: {
                    Authorization: `Bearer ${token}`
                }
            });

            resgisterClient.reset();
            Swal.fire({
                icon: 'success',
                title: 'Cliente registrado',
                text: 'El cliente ha sido registrado exitosamente'
            });
            loadClientes();
        } catch (error) {
            if (error.response) {
                console.error('Error de respuesta del servidor:', error.response.data);
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: error.response.data.message || 'Error de respuesta del servidor'
                });
            } else if (error.request) {
                console.error('No se recibió respuesta del servidor:', error.request);
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'No se recibió respuesta del servidor'
                });
            } else {
                console.error('Error al configurar la solicitud:', error.message);
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'Error al configurar la solicitud'
                });
            }
        }
    });

    async function loadClientes() {
        try {
            const response = await axios.get('/api/v1/clientes/list', {
                headers: {
                    Authorization: `Bearer ${token}`
                }
            });
            const clientes = response.data;
            const tableBody = document.getElementById('clientesTbBd');
            tableBody.innerHTML = '';

            if (!clientes.length) {
                tableBody.innerHTML = `
                    <tr>
                        <td colspan="8" class="text-center">No hay clientes registrados</td>
                    </tr>
                `;
                return;
            }

            clientes.forEach(cliente => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${cliente.id_cliente}</td>
                    <td>${cliente.nombre}</td>
                    <td>${cliente.primer_apellido}</td>
                    <td>${cliente.segundo_apellido}</td>
                    <td>${cliente.telefono_1}</td>
                    <td>${cliente.telefono_2}</td>
                    <td>${cliente.email}</td>
                    <td>
                        <button class="btn btn-warning btn-sm" onclick="updateCliente('${cliente.id_cliente}')">Actualizar</button>
                        <button class="btn btn-danger btn-sm" onclick="deleteCliente('${cliente.id_cliente}')">Eliminar</button>
                    </td>
                `;
                tableBody.appendChild(row);
            });
        } catch (error) {
            console.error('Error al cargar los clientes:', error);
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: error.response?.data?.message || 'Error al cargar los clientes'
            });
        }
    }

    async function deleteCliente(id_cliente) {
        try {
            await axios.delete(`/api/v1/clientes/${id_cliente}`, {
                headers: {
                    Authorization: `Bearer ${token}`
                }
            });
            console.log('Cliente eliminado con éxito');
            Swal.fire({
                icon: 'success',
                title: 'Cliente eliminado',
                text: 'El cliente ha sido eliminado exitosamente'
            });
            loadClientes();
        } catch (error) {
            console.error('Error al eliminar el cliente:', error);
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: error.response?.data?.message || 'Error al eliminar el cliente'
            });
        }
    }

    async function updateCliente(id_cliente) {
        const updateFields = {
            nombre: prompt('Nuevo nombre:'),
            primer_apellido: prompt('Nuevo primer apellido:'),
            segundo_apellido: prompt('Nuevo segundo apellido:'),
            telefono_1: prompt('Nuevo teléfono 1:'),
            telefono_2: prompt('Nuevo teléfono 2:'),
            email: prompt('Nuevo correo electrónico:')
        };

        const cleanFields = Object.fromEntries(
            Object.entries(updateFields).filter(([_, value]) => value !== null && value !== '')
        );

        if (Object.keys(cleanFields).length === 0) {
            return;
        }

        try {
            await axios.patch(`/api/v1/clientes/${id_cliente}`, cleanFields, {
                headers: {
                    Authorization: `Bearer ${token}`
                }
            });
            console.log('Cliente actualizado con éxito');
            Swal.fire({
                icon: 'success',
                title: 'Cliente actualizado',
                text: 'El cliente ha sido actualizado exitosamente'
            });
            loadClientes();
        } catch (error) {
            console.error('Error al actualizar el cliente:', error);
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: error.response?.data?.message || 'Error al actualizar el cliente'
            });
        }
    }

    async function searchCliente() {
        const searchInput = document.getElementById('searchInput').value.trim();
        try {
            const response = await axios.get(`/api/v1/clientes/search?query=${searchInput}`, {
                headers: {
                    Authorization: `Bearer ${token}`
                }
            });
            const clientes = response.data;
            if (!Array.isArray(clientes)) {
                throw new Error('La respuesta no es un array');
            }
            const tableBody = document.getElementById('clientesTbBd');
            tableBody.innerHTML = '';

            clientes.forEach(cliente => {
                const row = document.createElement('tr');
                row.innerHTML = `
                    <td>${cliente.id_cliente}</td>
                    <td>${cliente.nombre}</td>
                    <td>${cliente.primer_apellido}</td>
                    <td>${cliente.segundo_apellido}</td>
                    <td>${cliente.telefono_1}</td>
                    <td>${cliente.telefono_2}</td>
                    <td>${cliente.email}</td>
                    <td>
                        <button class="btn btn-warning btn-sm" onclick="updateCliente('${cliente.id_cliente}')">Actualizar</button>
                        <button class="btn btn-danger btn-sm" onclick="deleteCliente('${cliente.id_cliente}')">Eliminar</button>
                    </td>
                `;
                tableBody.appendChild(row);
            });
        } catch (error) {
            console.error('Error al buscar el cliente:', error);
            Swal.fire({
                icon: 'error',
                title: 'Error',
                text: error.response?.data?.message || 'Error al buscar el cliente'
            });
        }
    }

    window.deleteCliente = deleteCliente;
    window.updateCliente = updateCliente;
    window.loadClientes = loadClientes;
    window.searchCliente = searchCliente;
    loadClientes();
});
