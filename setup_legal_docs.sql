-- Enable UUID extension if not already enabled
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Create the legal_documents table
CREATE TABLE IF NOT EXISTS public.legal_documents (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  document_type TEXT NOT NULL UNIQUE, -- 'privacy_policy', 'terms_of_service', 'cookies_policy'
  content TEXT NOT NULL, -- Markdown content
  effective_date TIMESTAMPTZ DEFAULT NOW(),
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMPTZ DEFAULT NOW(),
  updated_at TIMESTAMPTZ DEFAULT NOW()
);

-- Add Row Level Security (RLS)
ALTER TABLE public.legal_documents ENABLE ROW LEVEL SECURITY;

-- Allow public read access to active documents
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_policies WHERE tablename = 'legal_documents' AND policyname = 'Public can view active legal documents'
    ) THEN
        CREATE POLICY "Public can view active legal documents" 
        ON public.legal_documents
        FOR SELECT 
        USING (is_active = true);
    END IF;
END
$$;

-- Add comprehensive simple-English data (Expanded to 300+ lines)
INSERT INTO public.legal_documents (document_type, content, is_active)
VALUES 
  ('privacy_policy', '# Privacy Policy

*Last Updated: Today*

Welcome to the Crimchart Privacy Policy. We wrote this in simple English so you can easily understand what we do with your information. Your privacy is very important to us, and we want to be completely transparent about how we handle your data.

## 1. Who We Are
We are the team behind Crimchart. When we say "we," "us," or "our," we mean Crimchart. When we say "app" or "service," we mean the Crimchart application you use on your phone or computer, as well as our website.

## 2. What Information We Collect
We only collect information that we actually need to make the app work for you. We divide this into two categories: information you give us, and information we collect automatically.

**Information you give us directly:**
*   **Account Details:** When you sign up, you give us your name, email address, username, and password. If you sign up using Google or Apple, we receive basic info from them (like your name and email).
*   **Profile Information:** You might choose to add a profile picture, a short bio, your music preferences, or other details to your public profile. You don''t have to provide this, but it makes the app more fun.
*   **Your Content:** Anything you post, upload, or share on Crimchart (like text posts, comments, photos, videos, or reactions) is stored by us so others can see it.
*   **Messages:** If you send private messages to other users, we store those messages to deliver them securely.
*   **Support Requests:** If you email us for help, we keep a record of that conversation so we can assist you.

**Information we collect automatically:**
*   **Device Information:** We see what kind of phone or computer you use, your operating system version, your device settings, battery level, signal strength, and your IP address. This helps us fix bugs and keep the app secure.
*   **Usage Data:** We look at how you interact with the app. For example, what pages you visit, what buttons you click, how long you stay on the app, and what features you use the most. This helps us know what to improve in the next update.
*   **Location Information:** We may collect general location data based on your IP address (like what city or country you are in) so we can show you relevant content. We do not track your exact GPS location unless you give us specific permission.

## 3. App Permissions
To use certain features, the app will ask for permission to access parts of your phone:
*   **Camera and Photos:** We need this permission if you want to take a photo or video to post on your profile or feed. We only access the photos you specifically select.
*   **Microphone:** We need this if you want to record videos with sound.
*   **Notifications:** We ask for this so we can send you a message when someone likes your post or sends you a direct message.
You can turn these permissions on or off at any time in your phone''s settings.

## 4. Cookies and Tracking Technologies
Cookies are small text files placed on your device to help the app remember you. 
*   **Why we use them:** We use cookies to keep you logged in, to remember your theme settings (like Dark Mode), and to understand how people use our website.
*   **Third-Party Trackers:** We may use tools like Google Analytics to understand our traffic. These tools may place their own cookies on your device.
*   **Your choices:** You can set your browser or phone to block cookies, but if you do, some parts of Crimchart might not work properly (for example, you might have to log in every time you open the app).
*   **Do Not Track:** Some browsers have a "Do Not Track" feature. Right now, our app does not respond to these signals because there is no universal standard for them yet.

## 5. How We Use Your Information
We do not sell your personal data to anyone. We use your information for these main reasons:
*   **To run the app:** We need your info to create your account, show your feed, deliver your messages, and let you interact with friends.
*   **To personalize your experience:** We use your data to figure out what posts you might like and show them to you.
*   **To keep you safe:** We use data to find and stop spam, fraud, fake accounts, and bad behavior.
*   **To fix bugs:** If the app crashes, we look at device data to figure out why it crashed so we can fix it for everyone.
*   **To communicate with you:** We might send you push notifications or emails about new features, security alerts, or important updates.

## 6. Sharing Your Information
We try to keep your data to ourselves, but sometimes we have to share it to make the app work:
*   **With other users:** Things you post publicly, your username, and your profile picture can be seen by other people on Crimchart.
*   **With service providers:** We hire other companies to help us run the app (like cloud servers to store data, or email services to send you password resets). We only give them the information they need to do their job, and they are legally required to keep it safe and private.
*   **For legal reasons:** If the law says we have to share data (like a search warrant or a court order), we will do it. We will also share data if we believe it is absolutely necessary to protect someone from getting hurt, to stop illegal activity, or to protect our own legal rights.
*   **Business Transfers:** If Crimchart is ever bought by another company, or if we merge with another company, your data will be transferred to them. We will let you know before this happens.

## 7. How Long We Keep Your Data
We keep your personal information only as long as we need it to provide you with the Crimchart service, or as long as the law requires us to keep it.
*   **Active Accounts:** As long as your account is active, we keep your data so you can use the app.
*   **Deleted Accounts:** If you delete your account, we will delete your public profile, posts, and personal information from our active servers. Please note that it might take up to 30 days to completely remove everything from our backup systems.
*   **Exceptions:** We might keep some data longer if we need it for legal reasons, or to investigate a violation of our rules.

## 8. Your Rights and Choices
You have a lot of control over your data:
*   **Update your info:** You can change your profile details, email address, and password at any time in the app settings.
*   **Delete your account:** You can permanently delete your account from the settings menu. Once deleted, you cannot get your data back.
*   **Download your data:** You have the right to request a copy of the personal data we hold about you. Contact support to arrange this.
*   **Opt-out of emails:** You can click "unsubscribe" at the bottom of our emails if you don''t want marketing or update emails anymore. (You will still get important security emails).

## 9. Specific Regional Privacy Rights
Depending on where you live, you might have extra rights:
*   **California Residents (CCPA):** You have the right to know what data we collect, to request that we delete it, and to opt out of the "sale" of your data (though as we said, we don''t sell your data).
*   **European Union (GDPR):** You have the right to access, correct, erase, restrict, or object to the processing of your personal data. You also have the right to data portability.
*   **To exercise these rights:** Please email us at the address at the bottom of this page. We will respond within 30 days.

## 10. Security and Data Breaches
We work hard to protect your information. We use strong security measures, like encryption, to prevent hackers from stealing your data while it travels between your phone and our servers. We also limit which of our employees can access user data.
If we ever experience a data breach (where hackers steal user information), we will notify you and the proper authorities as quickly as possible, and we will tell you exactly what steps to take to protect yourself.
However, remember that no system on the internet is 100% perfectly secure. Please do your part by keeping your password safe, not using the same password you use for other sites, and never sharing your login details.

## 11. International Data Transfers
Crimchart is used by people all over the world. This means your information might be sent to, stored, and processed in a country different from where you live (like the United States). By using our app, you agree to this transfer. We make sure that your data is protected no matter where it is stored.

## 12. Children''s Privacy
Crimchart is not meant for young children. You must be at least 13 years old (or older depending on your country''s laws) to use the app. We do not knowingly collect personal information from children under 13. If you are a parent and you believe your child has created an account, please contact us and we will delete it immediately.

## 13. Changes to this Policy
Sometimes we might change this Privacy Policy to reflect new features or new laws. If we make small changes, we will just update the "Last Updated" date at the top. If we make big, important changes, we will let you know by putting a notice in the app or sending you an email. 

## 14. Contact Us
If you have any questions, concerns, or complaints about this Privacy Policy or how we handle your data, please reach out to us. We are here to help!
Email: privacy@crimchart.com
', true),
  ('terms_of_service', '# Terms of Service

*Last Updated: Today*

Welcome to Crimchart! We are very happy to have you here. Please read these rules carefully. By downloading, opening, or using our app, you are making a legal agreement with us and agreeing to these terms. If you don''t agree with them, you must stop using the app immediately. We tried to write this in simple English so it''s easy to read and understand.

## 1. Basic Rules and Eligibility
*   **Age Limit:** You must be at least 13 years old to use Crimchart. If the laws in your country require you to be older to give consent for data processing, then you must be that older age.
*   **Be Honest:** You must provide true and accurate information when making an account. Don''t pretend to be someone else, and don''t create fake accounts.
*   **One Account Per Person:** You should generally only use one account. Don''t create multiple accounts to harass people or cheat our systems.
*   **Keep Your Account Safe:** You are entirely responsible for keeping your password secret. If someone guesses your password and does something bad on your account, you are responsible for it. Let us know immediately if you think someone hacked your account.
*   **Device Updates:** You are responsible for keeping your phone updated and secure. The app requires internet data to work, and you are responsible for paying any data charges from your mobile carrier.

## 2. Your Content
When we say "Content," we mean the text, photos, videos, comments, and anything else you post on Crimchart.
*   **You Own It:** You own all the rights to the original content you post. We do not claim ownership of your stuff.
*   **Our License to Use It:** To show your posts to other people on the app, we need your legal permission. By posting content, you give us a worldwide, free, non-exclusive license to use, display, store, copy, and share your content on our app. This license ends when you delete your content or your account.
*   **Don''t Steal:** Only post things that you actually have the right to post. Do not post copyrighted music, movies, images, or text that belongs to someone else without their permission. If you steal content, we will take it down.
*   **Feedback:** If you send us ideas, feedback, or suggestions on how to improve the app, we can use those ideas without paying you or asking for permission.

## 3. Acceptable Use Policy (What Is NOT Allowed)
We want Crimchart to be a safe, positive, and fun place for everyone. You are strictly forbidden from doing any of the following:
*   **No Bullying or Harassment:** Do not insult, threaten, stalk, or bully anyone. Do not encourage others to gang up on someone.
*   **No Hate Speech:** Do not attack people based on their race, religion, gender, sexual orientation, or disability.
*   **No Illegal Stuff:** Do not use the app to sell illegal goods, plan crimes, or do anything that breaks the law.
*   **No Spam:** Do not send spam, junk messages, run scams, or post repetitive annoying content.
*   **No Nudity or Graphic Violence:** Do not post explicit sexual content, pornography, or extreme, shocking violence.
*   **No Self-Harm:** Do not post content that encourages or glorifies self-harm or eating disorders.
*   **No Hacking or Cheating:** Do not try to hack our servers, introduce viruses, scrape data using bots, or find ways to break the app''s features. Do not reverse engineer our code.

If you break these rules, we can delete your posts, suspend your account, or permanently ban you from Crimchart without any warning.

## 4. Moderation and Appeals
*   **Reporting:** If you see someone breaking the rules, please use the report button in the app. Our team reviews reports and takes action.
*   **Appeals:** If we ban your account or remove your content and you think we made a mistake, you can email us to appeal the decision. We will review your case, but our final decision is final.

## 5. In-App Purchases and Virtual Currency
*   **Purchases:** We may offer paid features, subscriptions, or virtual items. When you buy something, you are paying for a limited license to use that feature.
*   **No Refunds:** Unless the law requires it, all purchases are final and non-refundable. 
*   **No Real Money Value:** Virtual coins, gifts, or items have no real-world cash value. You cannot sell them to other users or exchange them for real money.

## 6. Our Rights and Our Content
*   **We Can Change the App:** We are always updating and improving Crimchart. We might add exciting new features, or we might decide to remove old features. We can make these changes at any time without asking you first.
*   **We Can Remove Content:** We are not responsible for what users post, but we have the right (though not the obligation) to review content and remove anything that breaks our rules or that we think is harmful to the community.
*   **Our Intellectual Property:** Other than the content you own, everything else on the app belongs to us. This includes our logos, the design of the app, our code, our name, and our custom features. You cannot copy, sell, or use our intellectual property without our written permission.

## 7. Copyright Infringement (DMCA)
We respect the intellectual property rights of others. If you believe someone on Crimchart has stolen your copyrighted work and posted it without permission, please send us a formal takedown notice with proof. We will investigate and remove the stolen content, and we will ban users who repeatedly steal content.

## 8. Third-Party Links
Sometimes users might post links to other websites outside of Crimchart. We do not control those outside websites. If you click a link and go to another website, you do so at your own risk. We are not responsible if that website gives you a virus, tries to scam you, or shows you something bad.

## 9. App Store Rules
If you downloaded Crimchart from the Apple App Store or the Google Play Store, their rules also apply to you. Apple and Google are not responsible for Crimchart, they just provide the store to download it. If you have a problem with the app, you need to contact us, not Apple or Google.

## 10. Disclaimers (Important Legal Stuff)
Please read this carefully.
*   **"As Is":** We provide the Crimchart app strictly on an "as is" and "as available" basis. This means we do not make any promises that the app will always work perfectly, that it will be 100% bug-free, or that it will be completely safe from hackers. 
*   **No Guarantees:** We do not guarantee that you will never see offensive content. We do our best to moderate the app, but things slip through.
*   **Your Risk:** You use the app at your own risk.

## 11. Limitation of Liability
To the maximum extent allowed by the law, Crimchart, its founders, and its employees will NOT be liable for any damages that happen from using our app. This includes lost profits, lost data, damaged devices, or emotional distress. If something goes terribly wrong, the absolute maximum amount of money we can be held liable for is $50 (fifty US dollars) or the amount you paid us in the last 12 months, whichever is greater.

## 12. Indemnification
If you do something bad on the app (like steal someone''s copyright or break the law) and Crimchart gets sued because of your actions, you agree to step in and pay for our legal fees, lawyers, and any damages a judge orders us to pay.

## 13. Resolving Disputes and Arbitration
*   **Talk First:** If you have a problem with us, please email us first so we can try to fix it informally.
*   **Mandatory Arbitration:** If we can''t fix it, you agree that any legal dispute will be solved through binding arbitration, not in a traditional court of law in front of a judge or jury.
*   **No Class Actions:** You agree that you can only sue us on your own behalf. You cannot join a class-action lawsuit against Crimchart.

## 14. Governing Law and Severability
*   **Governing Law:** These rules are governed by the laws of our company''s home state or country, regardless of where you live.
*   **Severability:** If a judge decides that one specific rule in this document is illegal or unenforceable, that rule will be removed, but the rest of the document will still apply.

## 15. Ending Your Account
You can stop using Crimchart and delete your account at any time, for any reason. We can also terminate your account at any time if you break these rules. When your account ends, this agreement ends, but the important legal sections (like Disclaimers, Limitation of Liability, Arbitration, and Governing Law) will continue to apply forever.

## 16. Changes to These Terms
We might update these rules from time to time. If we make small changes, we will just update the text. If we make big changes that affect your rights, we will let you know in the app or by email. If you keep using the app after the changes are posted, it means you agree to the new rules.

## 17. Contact Us
If you have any questions, concerns, or feedback about these Terms of Service, please reach out to our support team. We love hearing from our users!
Email: support@crimchart.com
', true)
ON CONFLICT (document_type) 
DO UPDATE SET content = EXCLUDED.content, updated_at = NOW();
