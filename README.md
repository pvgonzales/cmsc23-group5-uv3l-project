# ElGives: Elbi Donation System
#### Group Members:
**Gonzales, Paula Victoria** <br/>
**Leoncio, Kathleen Kate** <br/>
**Villapando, Harold** <br/>

## Project Description
ElGives: Elbi Donation System is a comprehensive mobile application designed to facilitate donating and managing donations between donors and organizations. It aims to streamline the donation process, improve transparency, and ensure efficient management of resources. <br/>

## Project Features
- User Authentication (Donor, Organization, Admin)
    - Donors, organizations, and administrators have their own secure accounts, ensuring authentication and access control. <br/>
- Donors
    - Donors can easily submit donations to various organizations through the platform.
    - They can generate QR codes for drop-off donations, making the process convenient and contactless. <br/>
- Organizations
    - Organizations have the capability to update the status of donations, providing transparency to donors.
    - They can open or close their status to accept donations based on their current needs.
    - Organizations can manage donation drives by adding, viewing, editing, and deleting them as necessary. <br/>
- Admin
    - Administrators oversee the platform and have the authority to view and approve organization accounts.
    - They can access and review all donations made through the system.
    - Administrators also have the ability to view all donor accounts for monitoring and management purposes. <br/>

## Installation guide
- To begin, make sure you have an android device to run the flutter app. 
- Turn on developer options and USB debugging on your android device's setting. After that, connect your android device to your laptop/PC through a usb connector.
- Once the device is connected, choose 'transfer files/photos' once it popped up on your android device's screen.
- Clone the necessary file for the flutter app on you computer and type 'flutter run' in the terminal. 
- It will automatically connect on your device and the flutter app will then open. 

## How to use
**User Registration and Authentication**
- To begin, users need to register for an account. They will provide necessary information such as email, username, password, address, and contact number. Once registered, users can log in securely using their credentials. The registered users are donors by default; hence, if they want to sign up as an organization, they must provide a photo as a proof that they are legitimate, an organization type, and description. <br/>

**Donor Actions**
- After logging in, donors can view all available organizations.
- If they click one organization, they will fill out a form providing details about the donation, such as type, date and time, address, contact number, weight, and preferred logistics.
- Once submitted, the donation will be recorded in the system, and donors can track its status. Also in this section, donors can create QR codes for drop-off donations.
- This QR code can be scanned by organizations to facilitate the donation drop-off process. <br/>

**Organization Actions**
- **Updating Donation Status**
  - Upon receiving donations, organizations can log in and update the status of each donation.
  - They will mark donations as confirmed, scheduled for pick up, complete, or canceled to keep donors informed. <br/>
- **Managing Donation Drives**
  - Organizations have the ability to create, view, edit, and delete donation drives.
  - They can set the description and name of the drive. <br/>
- **Opening/Closing Donation Status:**
  - Organizations can control the acceptance of donations by opening or closing their status.
  - This feature allows organizations to manage their capacity and resources effectively. <br/>

**Admin Actions**
- **Approving Organization Accounts**
  - Administrators review and approve organization accounts to ensure legitimacy.
  - They can access pending organization registrations and either approve or reject them.
- **Monitoring Donations**
  - Admins have access to a comprehensive dashboard displaying all donations made through the system.
  - They can analyze donation data for reporting and management purposes.
- **Viewing Donor Accounts**
  - Admins can also view details of all donor accounts, including registration information.
  - This feature enables admins to maintain oversight and address any issues or inquiries from donors. <br/>

**Logging Out**
- After completing their tasks, users should log out of their accounts to ensure security and privacy.
