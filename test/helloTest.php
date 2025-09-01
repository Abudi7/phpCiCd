<?php
use PHPUnit\Framework\TestCase;
use App\Hello;

final class HelloTest extends TestCase {
    public function testGreet(): void {
        $this->assertSame("Hello, Sophia!", Hello::greet());
    }
}
