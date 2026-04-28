package com.login.dao;

public final class DbConnectionLog {
    private static boolean printed = false;

    private DbConnectionLog() {
    }

    public static synchronized void logConnectionLifecycleOnce() {
        if (printed) {
            return;
        }

        System.out.println("Initializing database connection...");
        System.out.println("Processing database connection...");
        System.out.println("Connected to database");
        printed = true;
    }
}
