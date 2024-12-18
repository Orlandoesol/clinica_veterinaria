import jwt from 'jsonwebtoken';

export const verifyToken = (req, res, next) => {
    let token = req.headers.authorization

    if(!token) {
        return res.status(401).json({message: 'No token provided.'})
    }

    token = token.split("")

    try {

    } catch (error) {
        console.log(error)
        return res.status(400).json({message: 'Error verifying token.'})
    }//AQUI VAMOS...


}