CREATE TABLE IF NOT EXISTS `hm_blackout_generators` (
    `id` VARCHAR(50) NOT NULL PRIMARY KEY,
    `zone` VARCHAR(50) NOT NULL,
    `repaired` TINYINT(1) DEFAULT 1,
    `last_sabotage` BIGINT DEFAULT 0,
    `last_repair` BIGINT DEFAULT 0,
    `sabotaged_by` VARCHAR(50) DEFAULT NULL,
    `repaired_by` VARCHAR(50) DEFAULT NULL,
    INDEX `idx_zone` (`zone`),
    INDEX `idx_repaired` (`repaired`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `hm_blackout_zones` (
    `id` VARCHAR(50) NOT NULL PRIMARY KEY,
    `active` TINYINT(1) DEFAULT 0,
    `started_at` BIGINT DEFAULT 0,
    `ended_at` BIGINT DEFAULT 0,
    `total_blackouts` INT DEFAULT 0,
    INDEX `idx_active` (`active`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS `hm_blackout_intel_purchases` (
    `id` INT AUTO_INCREMENT PRIMARY KEY,
    `identifier` VARCHAR(50) NOT NULL,
    `npc_id` VARCHAR(50) NOT NULL,
    `zone_id` VARCHAR(50) NOT NULL,
    `price` INT NOT NULL,
    `purchased_at` BIGINT NOT NULL,
    INDEX `idx_identifier` (`identifier`),
    INDEX `idx_purchased_at` (`purchased_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
