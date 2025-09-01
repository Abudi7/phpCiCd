<?php

use App\Hello;
use PHPUnit\Framework\TestCase;

final class HelloTest extends TestCase {
    public function testGreet(): void {
        $this->assertSame("Hello, Sophia!", Hello::greet());
    }
}
