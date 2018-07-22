# radio.hecke.rs API
note this is the internal frontend ⇆ backend API (at least at the moment), not something you probably want to program against.

## Authentication
### `POST /api/auth/users`
register
```json
{
    "username": string,
    "password": string,
}
```

#### response
```json
{
    "username": string,
    "password": string,
    "token": string,
    "role": UserRole,
}
```

### `POST /api/auth/signin`
```json
{
    "username": string,
    "password": string,
}
```

#### response
as in `POST /api/auth/users`

### `GET /api/auth/user'
Authorization must be supplied: `Authorization: Bearer {token}`
#### response
```json
{
    "username": string,
    "password": string,
    "token": string,
    "role": UserRole,
}
```
