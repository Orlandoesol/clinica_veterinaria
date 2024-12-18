import bcryptjs from 'bcryptjs';
import jwt from 'jsonwebtoken';
import { UserModel } from "../models/user.model.js";

// ruta /api/v1/users/regUser
const regUser = async (req, res) => {
    try {
        console.log(req.body);//
        const { email, password ,role } = req.body;
        if (!email || !password || !role) {
            return res.status(400).json({ ok: false,
                                message: "Faltan campos!" });
        }
        const user = await UserModel.findOneByEmail(email);
        if (user) {
            return res.status(400).json({ ok: true,
                                        message: "El usuario ya existe" });
        }

        const salt = await bcryptjs.genSalt(10);
        const hashedPassword = await bcryptjs.hash(password, salt);
        const newUser = await UserModel.createUser({ email, password: hashedPassword, role });

        const token = jwt.sign({ email: newUser.email, role: newUser.role },
            process.env.JWT_SECRET,
            {
                expiresIn: '1h',
            }
        );

        return res.status(201).json({ ok: true,
            message: newUser})
        } catch (error) {
            console.log(error)
            return res.status(500).json({ 
                ok: false,
                message: "Error al crear usuario" });
            }
}


// ruta /api/v1/users/logUser
const logUser = async (req, res) => {
    try {
        const { email, password } = req.body;

        if (!email || !password) {
            return res.status(400).json({ error: "Campos requeridos!!"});
        }

        const user = await UserModel.findOneByEmail(email)
        if(!user) {
            return res.status(400).json({ error: "Usuario no existe!!" });
        }

        const isMatch = await bcryptjs.compare(password, user.password);
        if(!isMatch) {
            return res.status(400).json({ error: "Contraseña incorrecta!!" });
        }

        const token = jwt.sign({ email: newUser.email, role: newUser.role },
            process.env.JWT_SECRET,
            {
                expiresIn: '1h',
            }
        );

        return res.json({ ok: true,
                            message: {
                                token, role: user.role
                            }
                            })

    }catch{
        console.log(error)
        return res.status(500).json({ 
            ok: false,
            message: "Error al crear usuario" });
    }
}

export const UserController = {
    regUser,
    logUser
}