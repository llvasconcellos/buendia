/*
 * This script takes a database cleared by clear_server.sql and sets up
 * initial data for the MSF EMC in Magburaka, Sierra Leone.  It will
 * also double checks some data that should already be present and adds
 * it if missing.
 *
 * Bear in mind this assumes you are starting from a snapshot of our
 * development database and so doesn't add the whole concept dictionary.
 */

-- The OpenMRS user account used by the server will be set up by the
-- buendia-server package to have a username and password determined by
-- the SERVER_OPENMRS_USER and SERVER_OPENMRS_PASSWORD settings.

-- The Guest User account for end users will be created by the server.

SELECT @admin_id := user_id FROM users WHERE system_id = 'admin';

-- Make sure the set of allowed locales is correct.
UPDATE global_property SET property_value = 'en, en_GB_client'
    WHERE property = 'locale.allowed.list';

-- Make sure camp and zone locations are present.
-- ON DUPLICATE IGNORE is safe as there is a unique index on uuid.
INSERT INTO location (name, creator, date_created, uuid) VALUES
    ('Facility Kailahun', @admin_id, NOW(), '3449f5fe-8e6b-4250-bcaa-fca5df28ddbf')
    ON DUPLICATE KEY UPDATE uuid = uuid;
SELECT @emc_id := location_id FROM location
    WHERE uuid = '3449f5fe-8e6b-4250-bcaa-fca5df28ddbf';

INSERT INTO location (name, creator, date_created, uuid, parent_location) VALUES
    ('Triage', @admin_id, NOW(), '3f75ca61-ec1a-4739-af09-25a84e3dd237', @emc_id),
    ('Suspected Zone', @admin_id, NOW(), '2f1e2418-ede6-481a-ad80-b9939a7fde8e', @emc_id),
    ('Probable Zone', @admin_id, NOW(), '3b11e7c8-a68a-4a5f-afb3-a4a053592d0e', @emc_id),
    ('Confirmed Zone', @admin_id, NOW(), 'b9038895-9c9d-4908-9e0d-51fd535ddd3c', @emc_id),
    ('Morgue', @admin_id, NOW(), '4ef642b9-9843-4d0d-9b2b-84fe1984801f', @emc_id),
    ('Discharged', @admin_id, NOW(), 'd7ca63c3-6ea0-4357-82fd-0910cc17a2cb', @emc_id)
    ON DUPLICATE KEY UPDATE uuid = uuid;

-- Add the tents.
SELECT @suspect_id := location_id FROM location
    WHERE uuid='2f1e2418-ede6-481a-ad80-b9939a7fde8e';
SELECT @probable_id := location_id FROM location
    WHERE uuid='3b11e7c8-a68a-4a5f-afb3-a4a053592d0e';
SELECT @confirmed_id := location_id FROM location
    WHERE uuid = 'b9038895-9c9d-4908-9e0d-51fd535ddd3c';
INSERT INTO location (name, creator, date_created, uuid, parent_location) VALUES
    ('S1', @admin_id, NOW(), 'a72f944b-cb50-4bc5-9ac0-f93c44d71b10', @suspect_id),
    ('S2', @admin_id, NOW(), 'd81a33d9-2711-47e2-9d47-77e32e0281b9', @suspect_id),
    ('S3', @android, NOW(), 'c7a69e19-8650-11e4-9cc2-040ccecfdba4', @suspect_id),
    ('S4', @android, NOW(), 'c87ad5ab-8650-11e4-afd6-040ccecfdba4', @suspect_id),
    ('P1', @admin_id, NOW(), '0d36bdce-7f0a-11e4-88ec-42010af084c0', @probable_id),
    ('P2', @admin_id, NOW(), '0d36beb7-7f0a-11e4-88ec-42010af084c0', @probable_id),
    ('P3', @android, NOW(), 'c89d00a1-8650-11e4-a82d-040ccecfdba4', @probable_id),
    ('P4', @android, NOW(), 'c8ba4385-8650-11e4-8641-040ccecfdba4', @probable_id),
    ('C1', @admin_id, NOW(), '46a8cb21-d9eb-416d-86ee-90a018122859', @confirmed_id),
    ('C2', @admin_id, NOW(), '0a49d383-7019-4f1f-bf4b-875f2cd58964', @confirmed_id),
    ('C3', @admin_id, NOW(), '4443985e-adbc-4c90-aaac-b27635cb73ac', @confirmed_id),
    ('C4', @admin_id, NOW(), '3ca154be-afd1-4074-893d-596bcb423a54', @confirmed_id),
    ('C5', @admin_id, NOW(), '6b993dab-7f0a-11e4-88ec-42010af084c0', @confirmed_id),
    ('C6', @admin_id, NOW(), '0cce735e-a0c8-4b21-a05e-539b6bb93441', @confirmed_id),
    ('C7', @admin_id, NOW(), '5542080a-45db-435e-8505-8e65309ae9d5', @confirmed_id),
    ('C8', @admin_id, NOW(), '87233c64-125a-4e8e-b292-f866a8ecb2b4', @confirmed_id)
    ('C9', @android, NOW(), 'c8d6607a-8650-11e4-9dfb-040ccecfdba4', @confirmed_id),
    ('C10', @android, NOW(), 'c8f5a8d7-8650-11e4-81c0-040ccecfdba4', @confirmed_id)
    ON DUPLICATE KEY UPDATE uuid = uuid;
