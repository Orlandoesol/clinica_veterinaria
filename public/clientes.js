document.addEventListener('DOMContentLoaded', () => {
const resgisterClient = document.querySelector('#formCliente')
resgisterClient.addEventListener('submit', async e => {
    e.preventDefault();
    const id_cliente = e.target.id_cliente.value;
    const nombre = e.target.nombre.value;
    const primer_apellido = e.target.primer_apellido.value;
    const segundo_apellido = e.target.segundo_apellido.value;
    const telefono_1 = e.target.telefono_1.value;
    const telefono_2 = e.target.telefono_2.value;
    const email = e.target.email.value;

    try {//api/v1/clientes/register
        const { data } = await axios.post('/api/v1/clientes/register', {
            id_cliente, nombre, primer_apellido, segundo_apellido, telefono_1, telefono_2, email
        });
    resgisterClient.reset();
    Swal.fire({
        icon: 'success',
        title: 'Cliente registrado',
        text: 'El cliente ha sido registrado exitosamente'
    });
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

//Obtener los datos de la DB 
async function loadClientes() {
    try {
        const response = await axios.get('/api/v1/clientes/list');
        const clientes = response.data;
        const tableBody = document.getElementById('clientesTbBd');
        tableBody.innerHTML = ''; // Limpiar la tabla antes de agregar nuevos datos

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
            text: 'Error al cargar los clientes'
        });
    }
}
async function deleteCliente(id_cliente) {
    const token = localStorage.getItem('token');
    try {
        await axios.delete(`/api/v1/clientes/${id_cliente}`, {
            headers: {
                Authorization: `Bearer ${token}` // Enviar el token en los encabezados de la solicitud
            }
        });
        console.log('Cliente eliminado con éxito');
        Swal.fire({
            icon: 'success',
            title: 'Cliente eliminado',
            text: 'El cliente ha sido eliminado exitosamente'
        });
        loadClientes(); // Recargar la lista de clientes después de eliminar
    } catch (error) {
        console.error('Error al eliminar el cliente:', error);
        alert('Error al eliminar el Cliente');
        Swal.fire({
            icon: 'error',
            title: 'Error',
            text: error.response?.data?.message || 'Error al eliminar el cliente'
        });
    }
}

// Función para mostrar el formulario con los datos del cliente a actualizar
async function updateCliente(id_cliente) {
    const token = localStorage.getItem('token');
    const updateFields = {
        nombre: prompt('Nuevo nombre:'),
        primer_apellido: prompt('Nuevo primer apellido:'),
        segundo_apellido: prompt('Nuevo segundo apellido:'),
        telefono_1: prompt('Nuevo teléfono 1:'),
        telefono_2: prompt('Nuevo teléfono 2:'),
        email: prompt('Nuevo correo electrónico:')
    };

    try {
        const { data } = await axios.patch(`/api/v1/clientes/${id_cliente}`, updateFields, {
            headers: {
                Authorization: `Bearer ${token}` // Enviar el token en los encabezados de la solicitud
            }
        });
        console.log('Cliente actualizado con éxito');
        Swal.fire({
            icon: 'success',
            title: 'Cliente actualizado',
            text: 'El cliente ha sido actualizado exitosamente'
        });
        loadClientes(); // Recargar la lista de clientes después de actualizar
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
    const searchInput = document.getElementById('searchInput').value;
    try {
        const response = await axios.get(`/api/v1/clientes/search?query=${searchInput}`);
        const clientes = response.data;
        if (!Array.isArray(clientes)) {
            throw new Error('La respuesta no es un array');
        }
        const tableBody = document.getElementById('clientesTbBd');
        tableBody.innerHTML = ''; // Limpiar la tabla antes de agregar nuevos datos

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
            text: 'Error al buscar el cliente'
        });
    }
}

// Exponer las funciones globalmente para que puedan ser llamadas desde el HTML
window.deleteCliente = deleteCliente;
window.updateCliente = updateCliente;
window.loadClientes = loadClientes;
window.searchCliente = searchCliente;
});
