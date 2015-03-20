#!/bin/bash 

SSLKEYFILE="ssl.key"

if [[ $# -lt 1 ]]; then
        echo Usage: $0 encrypted_file
        exit 1
fi

FILE=$1

dd if=$FILE of=key_iv.enc bs=1 count=512 2>/dev/null
dd if=$FILE of=ciphertext bs=1 skip=512 2>/dev/null

openssl rsautl -inkey $SSLKEYFILE -decrypt -out key_iv.plain < key_iv.enc

KEYIV=`cat key_iv.plain | hexdump -v -e '1/1 "%02X"' | sed -r 's/(.{64})(.*)/-K \1 -iv \2/'`

openssl enc -d $KEYIV -aes-256-cbc < ciphertext > decrypted

dd if=decrypted of=sha256.bin bs=1 count=32 2>/dev/null
dd if=decrypted of=password bs=1 skip=32 2>/dev/null

cat sha256.bin | hexdump -v -e '1/1 "%02X"' > sha256sum.txt

echo "  password" >> sha256sum.txt

sha256sum -c sha256sum.txt

