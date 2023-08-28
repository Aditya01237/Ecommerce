const razorpay = require('razorpay');

const instance = new razorpay({
    key_id: 'rzp_test_WHKyCjI3F7uVCh',
    key_secret: 'gezL2C7V0Y6jqo8CmuSFeCYd'
});

module.exports = instance;