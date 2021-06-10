package com.womenwhocode.tokyo.meetupapi

data class MeetupAPIEvent(
    val id: String,
    val duration: Int,
    val name: String,
    val local_date: String,
    val local_time: String,
    val waitlist_count: Int,
    val yes_rsvp_count: Int,
    val venue: MeetupAPIEventVenue,
    val link: String,
    val description: String
) {
    data class MeetupAPIEventVenue(
        val name: String,
        val lat: Double?,
        val lon: Double?,
        val address_1: String?,
        val city: String?
    ) {
        constructor(name: String) : this(name, null, null, null, null)
    }
}
