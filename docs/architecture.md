# Architecture

Standard Rails **MVC**, with two extra layers: Pundit policies (authorization) and Draper decorators
(presentation).

| Layer | Location | Notes |
|---|---|---|
| Model | `app/models` | ActiveRecord; validations, associations, domain logic |
| View | `app/views` (HAML) | Dirs per resource: events, localities, locations, lodgings, users, dashboard, welcome, devise |
| Controller | `app/controllers`, `app/controllers/events/*` | Nested under `events` for registrations, hospitalities, assignments, copies |
| Policy | `app/policies` | One per resource; `ApplicationPolicy` base |
| Decorator | `app/decorators` | `UserDecorator`, `YpUserDecorator` |
| Uploader | `app/uploaders` | CarrierWave avatar |

## Domain model
- **Event** — has a **Location**; joined to **Locality** through `events_localities`.
- **Locality** — a group/church; has contacts, **Lodgings**, users.
- **Lodging** — hosts attendees; **Hospitality** ties an event + lodging + locality (+ registration).
- **Registration** — a **User** attending an **Event** for a **Locality**.
- **HospitalityRegistrationAssignment** — assigns registrations to hospitalities (unique per hospitality/registration/locality).
- **Note**, **Payment**, **Address** — supporting records. Search via `pg_search`.

Source of truth: `db/schema.rb`, `config/routes.rb`.

## Known smells to fix opportunistically
- `ApplicationController` (~177 lines) carries too much — extract concerns/services.
- `users.lodgings_id` is misnamed (plural) — migrate when touching users.
- `secret_controller_controller.rb` looks like a stray; confirm and remove.
