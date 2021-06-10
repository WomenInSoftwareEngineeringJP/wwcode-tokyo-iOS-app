package com.womenwhocode.tokyo.event

import java.time.LocalDateTime

data class WWCEvent(
    val id: String,
    val name: String,
    val startDateTime: LocalDateTime,
    val endDateTime: LocalDateTime,
    val description: String,
    val venue: Venue,
    val link: String
) {
    data class Venue(
        val name: String,
        val location: Location?
    )

    data class Location(
        val lat: Double,
        val lon: Double,
        val address: String,
        val city: String
    )
}
