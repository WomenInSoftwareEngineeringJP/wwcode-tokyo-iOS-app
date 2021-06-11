package com.womenwhocode.tokyo.event

data class RepositoryEvent(
    val id: String,
    val name: String,
    val date: String,
    val time: String,
    val duration: Int,
    val description: String,
    val venue: Venue?,
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
