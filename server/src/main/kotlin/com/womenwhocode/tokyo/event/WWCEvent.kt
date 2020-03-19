package com.womenwhocode.tokyo.event

import java.time.LocalDateTime

data class WWCEvent(
        val name: String,
        val startDateTime: LocalDateTime,
        val endDateTime: LocalDateTime,
        val description: String,
        val venueName: String
)
