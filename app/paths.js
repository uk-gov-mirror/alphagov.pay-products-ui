'use strict'

const generateRoute = require('./utils/generate_route.js')

module.exports = {
  default: {
    index: '/'
  },
  pay: {
    product: '/pay/:productExternalId',
    complete: '/payment-complete/:paymentExternalId'
  },
  demoPayment: {
    success: '/successful',
    failure: '/failed'
  },
  healthcheck: {
    path: '/healthcheck'
  },
  staticPaths: {
    naxsiError: '/request-denied'
  },
  generateRoute
}
