package com.womenwhocode.tokyo.web

data class MeetupEvent(
        val name: String,
        val local_date: String,
        val local_time: String,
        val waitlist_count: Int,
        val yes_rsvp_count: Int,
        val venue: MeetupVenue,
        val link: String,
        val description: String
) {
    data class MeetupVenue(
            val name: String,
            val lat: Double,
            val lon: Double,
            val address_1: String,
            val city: String)
}
