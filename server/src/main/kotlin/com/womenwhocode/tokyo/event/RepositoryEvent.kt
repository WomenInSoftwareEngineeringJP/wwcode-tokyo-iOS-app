package com.womenwhocode.tokyo.event

data class RepositoryEvent(
        val name: String,
        val date: String,
        val time: String,
        val duration: Int,
        val description: String,
        val venue: Venue
) {
    data class Venue(
            val name: String,
            val lat: Double,
            val lon: Double,
            val address: String,
            val city: String)
}
