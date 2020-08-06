# CapacitorPluginPOC

Demonstrate creating an own plugin and integrate with an existed web application with a simulated flow.

1. iOS: [Integration Guide](ios/README.md)
2. Android: TBD

## The Simulated Flow

1. The Web app invokes a native login flow.
2. Then User inputs a valid email to "*Get OTP*".
3. User inputs a valid OTP. Then Native flow callbacks to pass JWT's Token back to the Web app.
4. The web app consumes that token to invoke "*Authenticated APIs*" to get a list of products, categories, etc.
