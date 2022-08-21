# swift-hexagonal-architecture

Hexagonal Architecture using Vapor

<p align="center">
  <img width="500" src="https://github.com/santimattius/kotlin-hexagonal-architecture/blob/master/images/arch_hexa.png?raw=true" alt="Layers"/>
</p>

## Layers

**Domain**

Concepts that are in our context (User, Product, Cart, etc), and business rules that are determined exclusively by us (
domain services),

**Application**

The application layer is where the use cases of our application live (register user, publish product, add product to
cart, etc).

**Infrastructure**

Code that changes based on external decisions. In this layer will live the implementations of the interfaces that we
will define a domain level. That is, we will rely on the SOLID DIP to be able to decouple from external dependencies.

## HealthCheck

```shell
curl --location --request GET 'http://127.0.0.1:8080/healthcheck'
```

## Examples

Create new product

```shell
curl --location --request POST 'http://127.0.0.1:8080/product' \
--header 'Content-Type: application/json' \
--data-raw '{
    "id": "9e6fcea9-237e-4055-ab31-95f90aac2f80",
    "name": "new product name",
    "price": 120
}'
```

## Frameworks

- **Vapor**: [Documentation](https://docs.vapor.codes/)
