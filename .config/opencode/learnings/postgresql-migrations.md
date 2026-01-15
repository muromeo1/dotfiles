# PostgreSQL Production Migrations

## Concurrent Index Creation

- `algorithm: :concurrently` requires the DB user to be the **table owner**
- Error: `PG::InsufficientPrivilege: must be owner of table`

## Fixing Ownership

Fix single table:

```sql
ALTER TABLE public.<table> OWNER TO callbell_production_v2;
```

Fix all tables at once:

```sql
REASSIGN OWNED BY <old_owner> TO callbell_production_v2;
```

## Notes

- Ownership changes are **metadata-only** (sub-millisecond lock)
- Safe to run in production
- Consider running during low-traffic periods for peace of mind
