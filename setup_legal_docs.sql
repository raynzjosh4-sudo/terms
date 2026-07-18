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
CREATE POLICY "Public can view active legal documents" 
ON public.legal_documents
FOR SELECT 
USING (is_active = true);

-- Add some placeholder data for testing
INSERT INTO public.legal_documents (document_type, content, is_active)
VALUES 
  ('privacy_policy', '# Privacy Policy
  
Welcome to the Crimchart Privacy Policy. We are committed to protecting your personal information and your right to privacy.

## 1. Information We Collect
We collect personal information that you voluntarily provide to us when you register on the app, express an interest in obtaining information about us or our products and Services.

## 2. How We Use Your Information
We use personal information collected via our app for a variety of business purposes described below.

## 3. Will Your Information Be Shared With Anyone?
We only share information with your consent, to comply with laws, to provide you with services, to protect your rights, or to fulfill business obligations.

## 4. Contact Us
If you have questions or comments about this notice, you may email us at privacy@crimchart.com.
', true),
  ('terms_of_service', '# Terms of Service
  
Welcome to Crimchart. By using our application, you agree to be bound by these Terms of Service.

## 1. Acceptance of Terms
By accessing or using the Service, you agree to be bound by these Terms.

## 2. User Responsibilities
You are responsible for your use of the Service and for any content you provide.

## 3. Termination
We may terminate or suspend access to our Service immediately, without prior notice or liability.
', true)
ON CONFLICT (document_type) 
DO UPDATE SET content = EXCLUDED.content, updated_at = NOW();
