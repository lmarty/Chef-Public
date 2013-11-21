#!/usr/bin/env bats

@test "should have getaddrinfo label 'one'" {
    grep '# one' /etc/gai.conf
}

@test "should have getaddrinfo label 'two'" {
    grep '# two' /etc/gai.conf
}

@test "should have getaddrinfo precedence 'prefer ipv4'" {
    grep '# prefer ipv4' /etc/gai.conf
}

@test "should have getaddrinfo scope 'scoped'" {
    grep '# scoped' /etc/gai.conf
}
