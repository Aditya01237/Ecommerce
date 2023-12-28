const express = require('express');
const bodyParser = require('body-parser');
const helmet = require('helmet');
const morgan = require('morgan');
const cors = require('cors');
const mongoose = require('mongoose');

const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: false}));
app.use(helmet());
app.use(morgan('dev'));
app.use(cors());

mongoose.connect("mongodb+srv://aditya:aditya123@mycluster.vilnitc.mongodb.net/ecommerce?retryWrites=true&w=majority");

const UserRoutes = require('./routes/user_routes');
app.use("/api/user", UserRoutes);

const CategoryRoutes = require('./routes/category_routes');
app.use("/api/category", CategoryRoutes);

const ProductRoutes = require('./routes/product_routes');
app.use("/api/product", ProductRoutes);

const CartRoutes = require('./routes/cart_routes');
app.use("/api/cart", CartRoutes);

const OrderRoutes = require('./routes/order_routes');
app.use("/api/order", OrderRoutes);

app.get("/",function(req,res){
    res.send("Hello Public");
});

const PORT = 5000;
app.listen(PORT, () => console.log(`Server started on port: ${PORT}`));