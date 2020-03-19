package com.womenwhocode.tokyo.event

data class RepositoryEvent(
        val name: String,
        val date: String,
        val time: String,
        val duration: Int,
        val description: String,
        val venueName: String
)