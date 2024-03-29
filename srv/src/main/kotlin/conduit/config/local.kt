package conduit.config

import dev.nohus.autokonfig.types.Group
import org.http4k.core.Method
import org.http4k.filter.CorsPolicy

val auto = AppConfig(
    logConfig = "log4j2-local.yaml",
    db = object : Group("db") {
        val url by StringSetting()
        val driver by StringSetting()
    }.let {  DbConfig(url = it.url, driver = it.driver) },
    corsPolicy = CorsPolicy(
        origins = listOf("localhost:9000"),
        headers = listOf("content-type", "authorization"),
        methods = Method.values().toList(),
        credentials = true
    ),
    jwtConfig = JwtConfig(
        secret = "Top Secret",
        issuer = "thinkster.io",
        expirationMillis = 36_000_000
    ),
    port = 9000
)
