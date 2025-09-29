package br.edu.ifsp.pep.bcc;

public class Validators {
    public static boolean isValidCPF(String cpf) {
        if (cpf == null || cpf.length() != 11) return false;
        if (allSame(cpf)) return false;
        try {
            int sum = 0;
            for (int i = 0; i < 9; i++) sum += (cpf.charAt(i) - '0') * (10 - i);
            int dv1 = 11 - (sum % 11);
            if (dv1 >= 10) dv1 = 0;
            if (dv1 != (cpf.charAt(9) - '0')) return false;

            sum = 0;
            for (int i = 0; i < 10; i++) sum += (cpf.charAt(i) - '0') * (11 - i);
            int dv2 = 11 - (sum % 11);
            if (dv2 >= 10) dv2 = 0;
            return dv2 == (cpf.charAt(10) - '0');
        } catch (Exception e) {
            return false;
        }
    }

    public static boolean isValidCNPJ(String cnpj) {
        if (cnpj == null || cnpj.length() != 14) return false;
        if (allSame(cnpj)) return false;
        try {
            int[] w1 = {5,4,3,2,9,8,7,6,5,4,3,2};
            int[] w2 = {6,5,4,3,2,9,8,7,6,5,4,3,2};
            int sum = 0;
            for (int i = 0; i < 12; i++) sum += (cnpj.charAt(i) - '0') * w1[i];
            int r = sum % 11;
            int dv1 = (r < 2) ? 0 : 11 - r;
            if (dv1 != (cnpj.charAt(12) - '0')) return false;

            sum = 0;
            for (int i = 0; i < 13; i++) sum += (cnpj.charAt(i) - '0') * w2[i];
            r = sum % 11;
            int dv2 = (r < 2) ? 0 : 11 - r;
            return dv2 == (cnpj.charAt(13) - '0');
        } catch (Exception e) {
            return false;
        }
    }

    private static boolean allSame(String s) {
        char c = s.charAt(0);
        for (int i = 1; i < s.length(); i++) if (s.charAt(i) != c) return false;
        return true;
    }
}
