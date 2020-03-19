package com.womenwhocode.tokyo.event

import java.time.LocalDateTime

data class WWCEvent(
        val name: String,
        val startDateTime: LocalDateTime,
        val endDateTime: LocalDateTime,
        val description: String,
        val venue: Venue
) {
    data class Venue(
            val name: String,
            val lat: Double,
            val lon: Double,
            val address: String,
            val city: String
    )
}
