# sec505linux

This is a proof-of-concept script one can use as a starting point for writing a password recovery Linux bash script for this windows local admin password changing solution:

http://cyber-defense.sans.org/blog/2013/08/01/reset-local-administrator-password-automatically-with-a-different-password-across-the-enterprise

Please note that:

* it assumes RSA public key size is 4096

* I modified the Update-PasswordArchive.ps1 script to be more compatible with OpenSSL, however it is still compatible with Recover-PasswordArchive.ps1 (tested on Windows 8.1)

        * ISO10126 padding is deprecated -- replaced with PKCS7:

		`+ $Rijndael.Padding = [System.Security.Cryptography.PaddingMode]::PKCS7`
		`- $Rijndael.Padding = [System.Security.Cryptography.PaddingMode]::ISO10126`

        * explicit keysize and blocksize:

		`+ $Rijndael.KeySize = 256`
		`+ $Rijndael.BlockSize = 128`

* it is not necessarily secure to run "openssl enc -d -K ... -iv ..." on a system allowing other (not entirely trusted) users being logged in


