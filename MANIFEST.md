# Envm Manifest

The manifest allows your Ruby application to register environment variables with Envm.

## Example

```yaml
RAILS_ENV:
  description: "Rails environment"
  default: 'development'
EXTERNAL_API_URL:
  description: "URL for our external API used by foo"
  default: 'https://externalapp.dev'
DATABASE_URL:
  description: "Database connection URL"
  default: 'mysql2://root@127.0.0.0.1/db'
  secret: true
AWS_ACCESS_KEY:
  description: "Creds for AWS"
  secret: true
AWS_SECRET_ACESS_KEY:
  description: "Creds for AWS"
  secret: true
```

## Schema Reference

The manifest file must be in YAML format. Each item describes a single environment variable.

Here are the supported options

### description
***
(string, optional)

Used to describe the environment variable.

### default
***
(any, optional)

The default value for the environment variable. Envm will return this value if not set on the system.

### secret
***
(boolean, optional)

This value indicates whether the the value should be explictly set on the system on staging or production environments.
